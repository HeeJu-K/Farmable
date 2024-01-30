package com.example.foodsustainability.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@Configuration
@EnableWebSecurity
public class UserRegistrationSecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        // http
        //     .cors(cors -> cors
        //         .configurationSource(request -> {
        //             CorsConfiguration config = new CorsConfiguration();
        //             config.setAllowedOrigins(Arrays.asList("*")); // Allow all origins
        //             config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS")); // Allow common methods
        //             config.setAllowedHeaders(Arrays.asList("*")); // Allow all headers
        //             config.setAllowCredentials(true); // Allow credentials
        //             return config;
        //         })
        //     );
            
        
        // return http.build();
        // http
        //     .authorizeHttpRequests(authorize -> authorize
        //         .requestMatchers("/register").permitAll()
        //         .anyRequest().authenticated()
        //     );
        //     // .formLogin(formLogin -> formLogin
        //     //     .loginPage("/login")
        //     //     .permitAll()
        //     // )
        //     // .rememberMe(Customizer.withDefaults());

        http
            .authorizeHttpRequests(requests -> requests
                .requestMatchers("/**").permitAll()
                .anyRequest().authenticated())
            .csrf(csrf -> csrf.disable());

        return http.build();

        // return http.cors(withDefaults()).csrf(csrf -> csrf.disable())
        //         .authorizeHttpRequests(requests -> requests
        //                 .requestMatchers("/register/**")
        //                 .permitAll())
        //         .authorizeHttpRequests(requests -> requests
        //                 .requestMatchers("/users/**")
        //                 .hasAnyAuthority("USER", "ADMIN")).formLogin(withDefaults()).build();

    }
}





// @Bean
// public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//     return http
// 1.      .authorizeRequests(auth -> {
// 2.           auth.requestMatchers("/").permitAll();
// 3.           auth.requestMatchers("/api/v1/customers/**").hasRole( 
//              "USER");
// 4.           auth.requestMatchers("/api/v1/documents/**").hasRole( 
//              "ADMIN");
// 5.           auth.anyRequest().authenticated();
//         })
// 6.      .csrf(csrf -> csrf.disable())
// 7.      .sessionManagement(session -> 
//             session.sessionCreationPolicy( 
//             SessionCreationPolicy.STATELESS))
// 8.      .httpBasic(it -> {})
// 9.      .build();