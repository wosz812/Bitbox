package com.bitbox;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.oauth2.resource.ResourceServerProperties;
import org.springframework.boot.autoconfigure.security.oauth2.resource.UserInfoTokenServices;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.NestedConfigurationProperty;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.oauth2.client.OAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.filter.OAuth2ClientAuthenticationProcessingFilter;
import org.springframework.security.oauth2.client.filter.OAuth2ClientContextFilter;
import org.springframework.security.oauth2.client.resource.OAuth2ProtectedResourceDetails;
import org.springframework.security.oauth2.client.token.grant.code.AuthorizationCodeResourceDetails;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableOAuth2Client;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.web.filter.CompositeFilter;
import org.springframework.web.util.WebUtils;

import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.StudentDTO;
import com.bitbox.service.IBitboxService;
import com.bitbox.service.SecurityService;

@SpringBootApplication
@EnableOAuth2Client
@EnableAuthorizationServer
public class BitBoxBoot1Application extends WebSecurityConfigurerAdapter {

	@Autowired
	OAuth2ClientContext oauth2ClientContext;
	@Autowired
	private UserDetailsService userDetailsService;
	@Autowired
	private SecurityService securityService;
	@Autowired
	private IBitboxService service;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		// new LoginUrlAuthenticationEntryPoint("/login/").
		// new SecurityContextHolderAwareRequestFilter().set
		// UsernamePasswordAuthenticationFilter.
		auth.userDetailsService(userDetailsService).passwordEncoder(securityService);
	}

	private AuthenticationSuccessHandler authenticationSuccessHandler() {
		return new SavedRequestAwareAuthenticationSuccessHandler() {
			@Override
			public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
					Authentication authentication) throws ServletException, IOException {
				Object object = authentication.getPrincipal();
				if (object instanceof StudentDTO) {
					StudentDTO sdto = (StudentDTO) object;
					String className = service.getClassName(sdto.getS_class_code());
					// session담기
					WebUtils.setSessionAttribute(request, "groupList", sdto.getGroup());
					WebUtils.setSessionAttribute(request, "className", className);
					WebUtils.setSessionAttribute(request, "id", sdto.getS_id());
					WebUtils.setSessionAttribute(request, "code", sdto.getS_class_code());
					WebUtils.setSessionAttribute(request, "img", sdto.getS_uuid_img());
				}
				super.onAuthenticationSuccess(request, response, authentication);
			}
		};
	}

	@Override
	// configure(HttpSecurity http) =인터셉터 요청을 안전하게 보호하는 방법설정.
	protected void configure(HttpSecurity http) throws Exception {
		http.formLogin().loginPage("/login").usernameParameter("s_id").passwordParameter("s_pw")
				.successHandler(authenticationSuccessHandler()).failureUrl("/login?check=1").permitAll();
		http.authorizeRequests().antMatchers( "/login/**", "/mail/**").permitAll()
				.antMatchers("/bitbox/**", "/git/**", "/memo/**").authenticated().anyRequest().authenticated().and()
				.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()).disable()
				.addFilterBefore(ssoFilter(), BasicAuthenticationFilter.class);

		// @formatter:on
	}

	@Configuration
	@EnableResourceServer
	protected static class ResourceServerConfiguration extends ResourceServerConfigurerAdapter {
		@Override
		public void configure(HttpSecurity http) throws Exception {
			// @formatter:off
			http.antMatcher("/me").authorizeRequests().anyRequest().authenticated();
			// @formatter:on
		}
	}

	public static void main(String[] args) {
		SpringApplication.run(BitBoxBoot1Application.class, args);
	}

	@Bean
	public FilterRegistrationBean oauth2ClientFilterRegistration(OAuth2ClientContextFilter filter) {
		FilterRegistrationBean registration = new FilterRegistrationBean();
		registration.setFilter(filter);
		registration.setOrder(-100);
		return registration;
	}

	@Bean
	@ConfigurationProperties("github")
	public ClientResources github() {
		return new ClientResources();
	}

	private Filter ssoFilter() {
		CompositeFilter filter = new CompositeFilter();
		List<Filter> filters = new ArrayList<>();
		filters.add(ssoFilter(github(), "/login/github"));
		filter.setFilters(filters);
		return filter;
	}

	@Bean
	public OAuth2RestTemplate oauth2RestTemplate(OAuth2ProtectedResourceDetails resource, OAuth2ClientContext context) {
		return new OAuth2RestTemplate(resource, context);
	}

	private Filter ssoFilter(ClientResources client, String path) {
		OAuth2ClientAuthenticationProcessingFilter oAuth2ClientAuthenticationFilter = new OAuth2ClientAuthenticationProcessingFilter(
				path);
		OAuth2RestTemplate oAuth2RestTemplate = new OAuth2RestTemplate(client.getClient(), oauth2ClientContext);
		oAuth2ClientAuthenticationFilter.setRestTemplate(oAuth2RestTemplate);
		UserInfoTokenServices tokenServices = new UserInfoTokenServices(client.getResource().getUserInfoUri(),
				client.getClient().getClientId());
		System.out.println();
		tokenServices.setRestTemplate(oAuth2RestTemplate);
		oAuth2ClientAuthenticationFilter.setTokenServices(tokenServices);
		SimpleUrlAuthenticationSuccessHandler ss = new SimpleUrlAuthenticationSuccessHandler("/git/gitBoardView");
		ss.setAlwaysUseDefaultTargetUrl(true);
		oAuth2ClientAuthenticationFilter.setAuthenticationSuccessHandler(ss);
		return oAuth2ClientAuthenticationFilter;
	}

}

class ClientResources {

	@NestedConfigurationProperty
	private AuthorizationCodeResourceDetails client = new AuthorizationCodeResourceDetails();

	@NestedConfigurationProperty
	private ResourceServerProperties resource = new ResourceServerProperties();

	public AuthorizationCodeResourceDetails getClient() {
		return client;
	}

	public ResourceServerProperties getResource() {
		return resource;
	}
}