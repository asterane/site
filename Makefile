# Makefile for asterane.github.io

.PHONY: deploy serve publish

deploy:
	@./deploy.sh

serve:
	@echo "Serving..."
	hugo serve --bind 0.0.0.0

publish:
	@echo "Publishing..."
	hugo

clean:
	@echo "Cleaning generated files..."
	@rm -rvf public/*
	@rm -rvf content/*
