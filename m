Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42400 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab3GNT5o (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sun, 14 Jul 2013 15:57:44 -0400
Received: by mail-we0-f174.google.com with SMTP id q58so9460463wes.19
        for <linux-modules@vger.kernel.org>; Sun, 14 Jul 2013 12:57:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1373802978-12456-1-git-send-email-teg@jklm.no>
References: <1373802978-12456-1-git-send-email-teg@jklm.no>
From: Kay Sievers <kay@vrfy.org>
Date: Sun, 14 Jul 2013 21:57:22 +0200
Message-ID: <CAPXgP10nK63V0pXRo-_jrudyu+ANRU=HCM3=R47hFrbucTLLeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] static-nodes: don't fail if modules.devname not found
To: Tom Gundersen <teg@jklm.no>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Sun, Jul 14, 2013 at 1:56 PM, Tom Gundersen <teg@jklm.no> wrote:

> @@ -170,13 +171,8 @@ static int do_static_nodes(int argc, char *argv[])
>                 }
>                 switch (c) {
>                 case 'o':
> -                       out = fopen(optarg, "we");
> -                       if (out == NULL) {
> -                               fprintf(stderr, "Error: could not create %s!\n",
> -                                       optarg);
> -                               ret = EXIT_FAILURE;
> -                               goto finish;
> -                       }
> +                       strncpy(output, optarg, PATH_MAX);

Not relevant for any common use case, but strncpy() sucks and will not
terminate with '\0', so we should probably just always add a '\0' to
the end.

Kay
