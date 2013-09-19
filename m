Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:64793 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3ISPtU (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 19 Sep 2013 11:49:20 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so3556772bkb.29
        for <linux-modules@vger.kernel.org>; Thu, 19 Sep 2013 08:49:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379602136-3937-1-git-send-email-dreisner@archlinux.org>
References: <1379602136-3937-1-git-send-email-dreisner@archlinux.org>
From: Tom Gundersen <teg@jklm.no>
Date: Thu, 19 Sep 2013 17:48:58 +0200
Message-ID: <CAG-2HqWhHvHypStzDZ+0=vpLW_Mg=oh7AAA-j8XpxMcpWcy=FQ@mail.gmail.com>
Subject: Re: [PATCH] static-nodes: add shell consumable format
To: Dave Reisner <dreisner@archlinux.org>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Sep 19, 2013 at 4:48 PM, Dave Reisner <dreisner@archlinux.org> wrote:
> This adds an additional format to kmod static-nodes, which writes
> output as shell commands, e.g.:
>
>   mknod '/dev/btrfs-control' c 10 234
>   mknod '/dev/loop-control' c 10 237
>   mkdir -m 755 -p '/dev/net'
>   mknod '/dev/net/tun' c 10 200
>
> Consumers of this format can simply pipe the output to a shell,
> creating the necessary static nodes. This could be useful for an
> initramfs which doesn't have systemd-tmpfiles but which still relies on
> static node creation which recent udev will no longer handle.

Seems reasonable enough, so if it is useful no objections from me.

However, two questions: why not simply ship systemd-tmpfiles in the
initramfs to do this (which would also do things like selinux labels
for those who care about that). Alternatively, why not just parse one
of the existing formats in your shell script?

-t

>  tools/static-nodes.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/static-nodes.c b/tools/static-nodes.c
> index 0195390..2d68537 100644
> --- a/tools/static-nodes.c
> +++ b/tools/static-nodes.c
> @@ -43,11 +43,13 @@ struct static_nodes_format {
>  static const struct static_nodes_format static_nodes_format_human;
>  static const struct static_nodes_format static_nodes_format_tmpfiles;
>  static const struct static_nodes_format static_nodes_format_devname;
> +static const struct static_nodes_format static_nodes_format_shell;
>
>  static const struct static_nodes_format *static_nodes_formats[] = {
>         &static_nodes_format_human,
>         &static_nodes_format_tmpfiles,
>         &static_nodes_format_devname,
> +       &static_nodes_format_shell,
>  };
>
>  static const char cmdopts_s[] = "o:f:h";
> @@ -126,6 +128,28 @@ static const struct static_nodes_format static_nodes_format_devname = {
>         .description = "the modules.devname format.",
>  };
>
> +static int write_shell(FILE *out, char modname[], char devname[], char type, unsigned int maj, unsigned int min)
> +{
> +       const char *dir = strrchr(devname, '/');
> +
> +       if (dir) {
> +               if (fprintf(out, "mkdir -m 755 -p '/dev/%.*s'\n",
> +                                       (int)(dir - devname), devname) < 0)
> +                       return EXIT_FAILURE;
> +       }
> +
> +       if (fprintf(out, "mknod '/dev/%s' %c %u %u\n", devname, type, maj, min) < 0)
> +               return EXIT_FAILURE;
> +
> +       return EXIT_SUCCESS;
> +}
> +
> +static const struct static_nodes_format static_nodes_format_shell = {
> +       .name = "shell",
> +       .write = write_shell,
> +       .description = "mknod commands for consumption by a shell.",
> +};
> +
>  static void help(void)
>  {
>         size_t i;
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
