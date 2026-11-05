# Site Ji Peixoto Professional — Liso Espelhado

Endereço previsto do site: **https://espelhadojipeixoto.com.br**  
Endereço atual no servidor: **https://liso.etoolstec.com.br** (Caddy aponta para a porta **8084**)

Este site **não tem painel** e **não tem banco de dados**.  
O que você posta no Instagram da marca aparece no site.  
WhatsApp e Instagram abrem em botões no canto da tela.

Pasta do projeto na VM: `/home/opc/prj/jipeioxoto`

---

## 1. O que você precisa preencher (obrigatório)

Abra o arquivo:

`lib/config/brand.dart`

Mude só estas linhas (é texto simples, como um bloco de notas):

### WhatsApp
Procure `whatsappNumber`.

Coloque o número **com código do país, DDD e número, sem espaço e sem +**.

Exemplo para (49) 99999-9999:

```
static const whatsappNumber = '5549999999999';
```

- Brasil = 55
- DDD = 49
- Número = 999999999

Se o botão do WhatsApp abrir a conversa errada, o número está incompleto.

### Instagram
Procure `instagramHandle`.

Coloque o nome da conta **sem @**.

```
static const instagramHandle = 'jipeixotoprofessional';
```

### E-mail e cidade
Procure `email` e `city` e troque pelos dados reais da marca.

---

## 2. Como fazer o Instagram aparecer no site

O Instagram **não deixa** o site ler a conta sozinho.  
Por isso usamos um serviço gratuito chamado **Behold**.

Passo a passo (pode pedir ajuda de alguém da família; não precisa ser programador):

1. Abra o computador e entre em: https://behold.so
2. Clique em criar conta (pode usar e-mail da marca).
3. Quando pedir para conectar uma rede, escolha **Instagram**.
4. Entre com a conta **oficial** da Ji Peixoto (a mesma que posta fotos).
5. Autorize o Behold a ler as publicações (ele só lê; não posta no seu lugar).
6. O Behold vai mostrar um **endereço de feed** (uma URL).  
   Parece com: `https://feeds.behold.so/xxxxxxxx`
7. Copie esse endereço.
8. Abra de novo `lib/config/brand.dart`.
9. Procure a linha:

```
static const beholdFeedUrl = '';
```

10. Cole o endereço entre as aspas:

```
static const beholdFeedUrl = 'https://feeds.behold.so/xxxxxxxx';
```

11. Salve o arquivo.
12. Peça para quem publica o site **gerar o site de novo** (passo 4 abaixo).

Pronto.  
Daí em diante: **postou no Instagram → atualizou o site** na próxima vez que alguém abrir a página.

Se essa linha ficar vazia, o site mostra fotos de exemplo (não são da marca).

### Se o Behold pedir senha do Instagram
Use a senha da conta da marca.  
Não coloque essa senha neste README nem no código do site.  
A senha fica só no Behold / Instagram.

---

## 3. Vídeos da seção “Vídeos”

Os vídeos vêm do YouTube.

1. Abra o vídeo no YouTube.
2. Olhe o link. Exemplo: `https://www.youtube.com/watch?v=jFxP1GYsggw`
3. A parte depois de `v=` é o código: `jFxP1GYsggw`
4. Em `lib/config/brand.dart`, dentro de `youtubeVideos`, troque o `id`, o título e o subtítulo.

Pode repetir o bloco `YoutubeVideo(...)` para mais de um vídeo.

---

## 4. Colocar o site no ar (Docker + Caddy)

O Caddy deste servidor já está assim:

```
liso.etoolstec.com.br {
    reverse_proxy localhost:8084
}
```

O container precisa **responder na porta 8084** da máquina.

Na pasta `/home/opc/prj/jipeioxoto`, rode:

```bash
docker compose up -d --build
```

Isso:
1. monta a imagem `jipeixoto-liso`
2. sobe o container `jipeixoto-liso`
3. publica **8084:8084**

Depois abra: **https://liso.etoolstec.com.br**

Comandos úteis:

```bash
make docker-up      # gera a imagem e sobe
make docker-logs    # vê se subiu
make docker-down    # para o container
```

Para atualizar o site depois de mudar um texto: rode de novo `docker compose up -d --build`.

Se a porta 8084 já estiver em uso, o container não sobe. Veja com `ss -lptn | grep 8084`.

O domínio hoje **ainda não aponta** para um servidor.  
Quando o DNS estiver pronto, publique a pasta `build/web` e o site abre nesse endereço.

---

## 5. O que o site já tem

- Home com texto da marca e chamada para WhatsApp / Instagram
- Kit Liso Espelhado: Selante A, Espelhado B, Cauty Liss C
- Home care Caviar Premium: shampoo, condicionador e máscara
- Passo a passo A → B → C + casa
- Vídeos
- Grade de publicações do Instagram
- Contato
- Botões flutuantes de WhatsApp (verde) e Instagram (rosa)

Cores (iguais às embalagens):

- Fundo branco
- Rosa magenta das tampas `#E2187A`
- Rosa claro `#FF4DA0`
- Preto `#111111`

---

## 6. Checklist antes de mostrar para o cliente

- [ ] Número de WhatsApp real
- [ ] @ do Instagram real
- [ ] E-mail real
- [ ] Behold conectado e URL colada
- [ ] Vídeos oficiais no YouTube
- [ ] Domínio `espelhadojipeixoto.com.br` apontando para a hospedagem
- [ ] Testar no celular: WhatsApp abre conversa, Instagram abre o perfil

---

## 7. Problemas comuns

**O WhatsApp abre, mas não é o número da marca**  
O campo `whatsappNumber` está errado ou incompleto.

**O feed do site não muda quando posto no Instagram**  
A URL do Behold está vazia, ou o Instagram não foi autorizado no Behold, ou o site não foi gerado de novo depois da alteração.

**Aparecem fotos que não são da marca**  
Ainda está no modo demonstração. Falta o passo 2.

**O site não abre em espelhadojipeixoto.com.br**  
O nome ainda não está ligado a um servidor (DNS). Isso se resolve no lugar onde o domínio foi comprado.
