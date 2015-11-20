MIME-Version: 1.0
In-Reply-To: <1448054594-1748-1-git-send-email-Marc-Antoine@Perennou.com>
References: <1448054594-1748-1-git-send-email-Marc-Antoine@Perennou.com>
Date: Fri, 20 Nov 2015 19:34:47 -0200
Message-ID: <CAKi4VA+OqbUn1+jc3CC5cy3fb182GRut14jZ6OzMjyUh95KKBQ@mail.gmail.com>
Subject: Re: [PATCH] insmod: fix wron fallthrough of -f
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Marc-Antoine Perennou <Marc-Antoine@perennou.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Fri, Nov 20, 2015 at 7:23 PM, Marc-Antoine Perennou
<Marc-Antoine@perennou.com> wrote:
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
> ---
>  tools/insmod.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/insmod.c b/tools/insmod.c
> index 045fd2c..c422971 100644
> --- a/tools/insmod.c
> +++ b/tools/insmod.c
> @@ -81,6 +81,8 @@ static int do_insmod(int argc, char *argv[])
>                 switch (c) {
>                 case 'p':
>                 case 's':
> +                       /* ignored, for compatibility only */
> +                       break;
>                 case 'f':
>                         flags |= KMOD_PROBE_FORCE_MODVERSION;
>                         flags |= KMOD_PROBE_FORCE_VERMAGIC;
> --

Applied, thanks.

Lucas De Marchi
