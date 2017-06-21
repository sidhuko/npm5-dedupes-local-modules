clean:
	find . -name "node_modules" -exec rm -rf '{}' +

clean-locks:
	find . -name "package-lock.json" -exec rm '{}' +
