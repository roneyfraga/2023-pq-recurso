
qr:
	quarto render

qrc:
	quarto render --cache-refresh

all:
	quarto render
	rsync -avzhe "ssh -i ~/.chave/chave_limpa" --info=progress2 --delete _book/ bibr@100.104.99.20:/var/www/roneyfraga.com/public_html/projects/2024-pq-recurso/

qp:
	quarto preview 

qs:
	rsync -avzhe "ssh -i ~/.chave/chave_limpa" --info=progress2 --delete _book/ bibr@100.104.99.20:/var/www/roneyfraga.com/public_html/projects/2024-pq-recurso/

