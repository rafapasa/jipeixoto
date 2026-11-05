.PHONY: get run build logo

# Recria a logo 3D a partir do arquivo de texto (MCP não envia JPG).
logo:
	mkdir -p assets/images
	python3 -c "import pathlib,base64; p=pathlib.Path('assets/images/logo.b64'); pathlib.Path('assets/images/logo_ji_peixoto.jpg').write_bytes(base64.b64decode(p.read_text())); pathlib.Path('assets/images/VXKLm.jpg').write_bytes(base64.b64decode(p.read_text()))"

get:
	flutter pub get
	$(MAKE) logo

run:
	flutter run -d chrome

build:
	flutter build web --release

docker-build:
	docker compose build

docker-up:
	docker compose up -d --build

docker-down:
	docker compose down

docker-logs:
	docker compose logs -f --tail=80
