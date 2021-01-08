Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14C5C433E0
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 03:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA97236F9
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 03:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbhAHDfs (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Jan 2021 22:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbhAHDfs (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Jan 2021 22:35:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2EAC0612F4
        for <linux-modules@vger.kernel.org>; Thu,  7 Jan 2021 19:35:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a12so19763643lfl.6
        for <linux-modules@vger.kernel.org>; Thu, 07 Jan 2021 19:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AZFTMoZeA79kK0OdHYyS/9xLL5Tuh1bJxrF8Peur3sc=;
        b=RNPc15hYcnNTK51t+5qWnDUqJTRAjNyVxqYE4nRy2qHsRykXG/oE+zoCx+l4sfVul1
         jIlsz4vEpz04YzBHWBN41snp0l2+py8hagRgPBp+3EWLiXCbLXifcpHYGOHRU0pKLy4G
         4V5bon+YM4OAidhWIYh5wW4AWDOl9OAfRpL0lkWIjiub2TkskId8W3Ia1VjFwSTaEx6c
         y/cgqz249ucKFYMlba6aA/4slh/ihoSw5peQPwYVB0N2XXVG2YXyOdLI5ud47QPkzYeb
         7vFGU4n6upUQc7dqDQgQcP/0crQpUS0PD+NrSQqXD8WrS6DIO3VdeZR95MeIn1oiE5zi
         F9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AZFTMoZeA79kK0OdHYyS/9xLL5Tuh1bJxrF8Peur3sc=;
        b=bp6ay1DMTw2w7+MWUq6SJiKo33Dmkxi1U4Q1IAiwejXH0NvYOOogNLye9zhssL7Do/
         ay1rQ52UKKRfXBCIdOWEimKz09g8a1UD3JuYhWguqFXo4oxDfMDeqpNANHZm/eUtY2IQ
         YAT/3fc+5QxzQ3swGnT56kvhkmtdGdasHLsfC7iqdRNz2AIjQlAoeVo2OXjV7+8cMbmo
         1o1xKyjXK7THFrzqdeYrk3xLVxWMlydO6iEXLUQTF7fGF5hf04+k7ukigqRV9aOQYdQK
         2JiMPCThjYxCsOhTIJrVZpoFgc5G/6F5jOAMuFY9gvUTb1HoQkTZEPlhalwEOH3wAkXu
         wvrw==
X-Gm-Message-State: AOAM533MY2LOAn5XVVqN250nQN2CM/a3Ds/NesgdXfUWHV70Lp0xau9o
        RCnCu1JLnoNaewXMMTuC8j8KwL8yC16AWnZ8j2Pg74urBrSaWw==
X-Google-Smtp-Source: ABdhPJw8OoVDWp1sGkzwv2pFD7CtiErjGoz/CkrFsmcTmAgBAKNsgd6u61AzQz2HvXLSEzpD17n0C/AqAPh40uP2Jd4=
X-Received: by 2002:a05:6512:202c:: with SMTP id s12mr860274lfs.220.1610076905187;
 Thu, 07 Jan 2021 19:35:05 -0800 (PST)
MIME-Version: 1.0
References: <X/e48mOg7WfVxRc0@bongo.bofh.it>
In-Reply-To: <X/e48mOg7WfVxRc0@bongo.bofh.it>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 7 Jan 2021 19:34:52 -0800
Message-ID: <CAKi4VA+RA8Sr85dHrRf9-XL5cJ8_rf=0WG68zQQQO6JA4qRPjw@mail.gmail.com>
Subject: Re: Bug#970871: "modinfo -F" always shows name for built-ins
To:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jan 7, 2021 at 5:55 PM Marco d'Itri <md@linux.it> wrote:
>
> The attached patch fixes this.

who is the author?

Lucas De Marchi
