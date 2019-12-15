package com.esicvr;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication

@EntityScan(basePackages = "com.esicvr.domain")
@ComponentScan("com.esicvr")
@Service("com.esicvr.service")
@EnableJpaRepositories(basePackages = "com.esicvr.repository")

@EnableTransactionManagement
@EnableAutoConfiguration

public class Application {

	/* ESICVR - SISTEMA INFORMATIZADO PARA CONTROLE DE VENDA DE ROUPA */
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
