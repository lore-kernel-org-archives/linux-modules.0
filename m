Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:44743 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab3GNM3s (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 14 Jul 2013 08:29:48 -0400
Received: by mail-qa0-f43.google.com with SMTP id d13so1131785qak.16
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 05:29:48 -0700 (PDT)
Date: Sun, 14 Jul 2013 08:29:45 -0400
From: Dave Reisner <d@falconindy.com>
To: Tom Gundersen <teg@jklm.no>
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/2] static-nodes: don't fail if modules.devname not found
Message-ID: <20130714122945.GB558@rampage>
References: <1373802978-12456-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373802978-12456-1-git-send-email-teg@jklm.no>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jul 14, 2013 at 01:56:17PM +0200, Tom Gundersen wrote:
> In containers/VM's/initrd one might not have installed any modules and accompanying modules.devname
> Don't fail if this is the case, just warn.
> 
> When used in systemd this means we don't get a failing unit on booting containers.
> ---
>  tools/static-nodes.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/static-nodes.c b/tools/static-nodes.c
> index 96bb71e..b4a3c08 100644
> --- a/tools/static-nodes.c
> +++ b/tools/static-nodes.c
> @@ -155,6 +155,7 @@ static int do_static_nodes(int argc, char *argv[])
>  {
>  	struct utsname kernel;
>  	char modules[PATH_MAX];
> +	char output[PATH_MAX];
>  	FILE *in = NULL, *out = stdout;
>  	const struct static_nodes_format *format = &static_nodes_format_human;
>  	char buf[4096];
> @@ -170,13 +171,8 @@ static int do_static_nodes(int argc, char *argv[])
>  		}
>  		switch (c) {
>  		case 'o':
> -			out = fopen(optarg, "we");
> -			if (out == NULL) {
> -				fprintf(stderr, "Error: could not create %s!\n",
> -					optarg);
> -				ret = EXIT_FAILURE;
> -				goto finish;
> -			}
> +			strncpy(output, optarg, PATH_MAX);

No need to copy anything here, just retain a pointer to this optarg.

> +			out = NULL;
>  			break;
>  		case 'f':
>  			valid = 0;
> @@ -221,12 +217,28 @@ static int do_static_nodes(int argc, char *argv[])
>  		 kernel.release);
>  	in = fopen(modules, "re");
>  	if (in == NULL) {
> -		fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
> -			kernel.release);
> -		ret = EXIT_FAILURE;
> +		if (errno == ENOENT) {
> +			fprintf(stderr, "Warning: /lib/modules/%s/modules.devname not found - ignoring\n",
> +				kernel.release);
> +			ret = EXIT_SUCCESS;
> +		} else {
> +			fprintf(stderr, "Error: could not open /lib/modules/%s/modules.devname - %m\n",
> +				kernel.release);
> +			ret = EXIT_FAILURE;
> +		}
>  		goto finish;
>  	}
>  
> +	if (out == NULL) {

It took me a minute to realize why this was the correct comparison.
Maybe it's just me, but I think this would be more readable if we did
something like the below psuedocode

  const char* output = "/dev/stderr";
  /* do option parsing, maybe reassigning 'output' */

  /* now open the file, regardless of what it is */
  FILE* out = fopen(output, "we");
  if (out == NULL)
    ...

Seems a bit cleaner to me, even if it duplicates a file descriptor (but
we'll open a new FILE regardless in the common use case).

> +		out = fopen(output, "we");
> +		if (out == NULL) {
> +			fprintf(stderr, "Error: could not create %s!\n",
> +				output);

I realize this is copied from the old code, but there's no explanation
as to why this failed. Add an %m token to the format string?

> +			ret = EXIT_FAILURE;
> +			goto finish;
> +		}
> +	}
> +
>  	while (fgets(buf, sizeof(buf), in) != NULL) {
>  		char modname[PATH_MAX];
>  		char devname[PATH_MAX];
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
