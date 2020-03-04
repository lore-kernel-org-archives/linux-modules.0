Return-Path: <SRS0=cK9R=4V=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED2C3F2CD
	for <linux-modules@archiver.kernel.org>; Wed,  4 Mar 2020 06:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986E62166E
	for <linux-modules@archiver.kernel.org>; Wed,  4 Mar 2020 06:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcJNYX0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgCDG20 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:28:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38898 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDG20 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 4 Mar 2020 01:28:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so886770wrw.5
        for <linux-modules@vger.kernel.org>; Tue, 03 Mar 2020 22:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7iirGWZeWJuiJqlYbjnfu47teMzRYzhNU3V02rEH0Y=;
        b=QcJNYX0WEIolz9Z/t4fzThvulbEpib0mCMIJ/vItn6VR+3Mo9S3cqj2Fxeo+dCXey3
         BSByFk9y1SWyaxmqoUjXJHgfBATodTngR9RW6Xb6muodRszXmVTDB5oB3j1wHOa8BeXg
         7r5FgGaB7q6oAAPLAQQoxeIdyASR6RDPAoH5Km1GtIT8j2cKQg03IplURpqnJ5bHlluZ
         ZDiBciKQr0AgI78sLKacRv6JMM+M/TjgyBI4hE/BjfVJrdygmpFVSDieFfFHnhoviljZ
         sMzDexofRgdGJlRaHmqE1Buf5ww3w/nRFJHpD+KQhrClRCktCfo5pWvKsUE2KU0dt/SE
         iXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7iirGWZeWJuiJqlYbjnfu47teMzRYzhNU3V02rEH0Y=;
        b=lkPiv0lGicl17n6TND9SJQqrzEaEZJymKbOwLddD9TAO+NlgS/9bpdROo+CMUVFycA
         Y9THhe7tneoL+GPJL2rUG5PAIvwwHRC4I1euJkeVYutxwr1ZDU1Uz57PCoiUxsJyreXJ
         hrIknrtb71G1EyeVsZfSmuWw9b/AcDZXIY6kcbYjY5Djy4o6qxU9Y0XQUhL2EL50TLUR
         xy0gL/dLjiDbetWK8n76C1Uf+o9dqGF5PxQCsbQXR4WEwXoI+QEqnpP9OliXQKcgfB6k
         KmC+8fOHtkEKYdTYB1MQI+PCFSsXD1fWLU4LP06AveS6u/durl3tzTSCy6qJeX6cOw0S
         7JEQ==
X-Gm-Message-State: ANhLgQ0lVnD9nES1dzqBB7QMuqa0zKHfU41Dm1yGOlXEzdoi+nj0Khps
        XhgMl99G/HKElymmaFBNz2prI8E+p89pA99VUk8=
X-Google-Smtp-Source: ADFU+vtuy03vbr1e3c6mPvrHDkKFS/5GHPqyZVDban+3SFkiVbhjPqqq12C7R5/5b83FGVvY7JwseGYWTjY1nsbpUmM=
X-Received: by 2002:a5d:6544:: with SMTP id z4mr2203177wrv.31.1583303303803;
 Tue, 03 Mar 2020 22:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20200221165243.25100-1-jeyu@kernel.org>
In-Reply-To: <20200221165243.25100-1-jeyu@kernel.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 3 Mar 2020 22:28:11 -0800
Message-ID: <CAKi4VA+uO-mdZ=gKpWdU6vq2_VJjhDkHS3KVZb3_6N2YGVhgiA@mail.gmail.com>
Subject: Re: [PATCH] depmod: account for new namespace field in Module.symvers
 (for kernel versions >= 5.4)
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 21, 2020 at 8:53 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> depmod -e -E is broken for kernel versions >= 5.4, because a new
> namespace field was added to Module.symvers. Each line is tab delimited
> with 5 fields in total. E.g.,
>
>         0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL
>
> When a symbol doesn't have a namespace, then the namespace field is empty:
>
>         0xb352177e\tfind_first_bit\t\tvmlinux\tEXPORT_SYMBOL

Why is namespace added in the *middle*? We remember we specifically
talked about compatibility back when this was added. Why is it not at
the end so tools that don't know about namespace don't stop working?

Lucas De Marchi

>
> Fix up depmod_load_symvers() so it finds the crc, symbol, and module
> ("where") fields correctly. Since there can be empty fields, strsep() is
> used instead of strtok(), since strtok() cannot handle empty fields
> (i.e., two delimiters in succession).
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>
> Hi,
>
> I was not sure what the best way of determining the symvers format was. I
> guess counting delimiters isn't the prettiest way, but if anyone has a
> better idea, let me know. Thanks!
>
>  tools/depmod.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index fbbce10..c5b9612 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -2577,7 +2577,9 @@ static int depmod_load_symvers(struct depmod *depmod, const char *filename)
>  {
>         char line[10240];
>         FILE *fp;
> -       unsigned int linenum = 0;
> +       unsigned int linenum = 0, cnt = 0;
> +       bool uses_namespaces = false;
> +       char *ptr;
>
>         fp = fopen(filename, "r");
>         if (fp == NULL) {
> @@ -2587,7 +2589,26 @@ static int depmod_load_symvers(struct depmod *depmod, const char *filename)
>         }
>         DBG("load symvers: %s\n", filename);
>
> -       /* eg. "0xb352177e\tfind_first_bit\tvmlinux\tEXPORT_SYMBOL" */
> +       /*
> +        * First, check for >=5.4 Module.symvers format:
> +        * "0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL"
> +        * If there are 5 fields (4 tabs), assume we're using the new format.
> +        */
> +       fgets(line, sizeof(line), fp);
> +       ptr = line;
> +       while ((ptr = strchr(ptr, '\t')) != NULL) {
> +               cnt++;
> +               ptr++;
> +       }
> +       if (cnt > 3)
> +               uses_namespaces = true;
> +       rewind(fp);
> +
> +       /*
> +        * eg. "0xb352177e\tfind_first_bit\tvmlinux\tEXPORT_SYMBOL"
> +        * Or if kernel version >=5.4:
> +        * "0xb352177e\tfind_first_bit\tnamespace\tvmlinux\tEXPORT_SYMBOL"
> +        */
>         while (fgets(line, sizeof(line), fp) != NULL) {
>                 const char *ver, *sym, *where;
>                 char *verend;
> @@ -2595,9 +2616,13 @@ static int depmod_load_symvers(struct depmod *depmod, const char *filename)
>
>                 linenum++;
>
> -               ver = strtok(line, " \t");
> -               sym = strtok(NULL, " \t");
> -               where = strtok(NULL, " \t");
> +               ptr = (char *)line;
> +               ver = strsep(&ptr, "\t");
> +               sym = strsep(&ptr, "\t");
> +               if (uses_namespaces) /* skip namespace field */
> +                       strsep(&ptr, "\t");
> +               where = strsep(&ptr, "\t");
> +
>                 if (!ver || !sym || !where)
>                         continue;
>
> --
> 2.16.4
>


-- 
Lucas De Marchi
