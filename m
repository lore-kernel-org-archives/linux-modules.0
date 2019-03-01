Return-Path: <SRS0=H8N3=RE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0578C43381
	for <linux-modules@archiver.kernel.org>; Fri,  1 Mar 2019 05:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827282186A
	for <linux-modules@archiver.kernel.org>; Fri,  1 Mar 2019 05:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZONLeLo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfCAFhO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:37:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33761 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCAFhO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 1 Mar 2019 00:37:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so24504682wrw.0
        for <linux-modules@vger.kernel.org>; Thu, 28 Feb 2019 21:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ph6rw3SUMLdUmUnQv/Lc3bgayRA/soDM9vFuvdJS94=;
        b=ZONLeLo3RoYx5Y3DpkUYarfq4Z4T/7O+8gXbWEYQ7Feq9Bsq5q3IMKN6yx0DcjgK6m
         5V0gmfW1WtKiZQ3jnFaMT/7uzzkC9OF22fEuNqD2JbSIcrjcEnvqtWy9Kh3alaB19fCo
         y23ZaIuVgUkwwG0+lWbQ3qlZLsM0dJFHU4BcDO+lvWgPNCnyVKk+d7Duw7TW+r91zjPk
         5cCgDoLmenXFuUZTaBv4qdjavvbfDFjub2sbUftPEtKDtijMGE3jKav9iLcgZppviihF
         Y37rUNL8xdy7CSj7rAIbHav9ypFR8pbDJpLbfxS1uLAeQmvw86Fx5cdHf3i/hcMPkyhT
         z79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0ph6rw3SUMLdUmUnQv/Lc3bgayRA/soDM9vFuvdJS94=;
        b=qgJy6aQiZiVtY1MgQ8gwV9lOFF6KlnrPMttoCoGK6SqedMUXWICm4R0r3ipF3HXtZj
         NISYUd3kZrHzQQy9IjDr/6s0RjiFPtRexWXXIvWeRskZxZ3YOtpx8UcF9G3i0+yqllXT
         3YLxn11XAZGjoWhs79paA4RKTVj8aFH+lOLmjPzWfQx3Ur54g6TxRrNva1RmJMhScKrX
         FF0Q7Ysze5Y0E8cyLbbW6sTa4XhErJ6fqnExNsm6pwmMkXfnseA0vJe3wGIkuzWWCent
         Hk61MAkIRDLMuNAnfV0oT6Ro9WbSakpFVsSCmZwWiCd6cHS9AyDxfdt4ptQFEJr1aFfD
         XrlA==
X-Gm-Message-State: APjAAAUROoVUpV7o2SHuPyixBlML4y8IxdQI9alC3Vud6qX7vuBvgAkZ
        o5fee/ITBiUIipxM3Q/8QQ==
X-Google-Smtp-Source: APXvYqzTNSwaPCmG+EQzCvYcCvBN4ehpoXDW6APD20y+xGIZ2P5jYwCdjszAB/Chgc3In2tnj6DVdQ==
X-Received: by 2002:adf:df0d:: with SMTP id y13mr1869010wrl.69.1551418631979;
        Thu, 28 Feb 2019 21:37:11 -0800 (PST)
Received: from [10.42.0.10] (pripet.hukot.net. [46.36.39.187])
        by smtp.googlemail.com with ESMTPSA id 132sm11562058wmd.30.2019.02.28.21.37.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 21:37:11 -0800 (PST)
From:   Stefan Strogin <stefan.strogin@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, ykaliuta@redhat.com
References: <20190215041340.29258-1-stefan.strogin@gmail.com>
 <20190215080422.hjl356xb7hui44iv@ldmartin-desk.jf.intel.com>
 <6633f8d3-c9d6-02d4-6226-204038df1f81@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.strogin@gmail.com; prefer-encrypt=mutual; keydata=
 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
 5D+adN5fqA==
Subject: Re: [PATCH] libkmod-signature: use PKCS7 for LibreSSL or older
 OpenSSL
Message-ID: <0916b8bc-383d-bcd4-432c-a1ec19db4e80@gmail.com>
Date:   Fri, 1 Mar 2019 07:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <6633f8d3-c9d6-02d4-6226-204038df1f81@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas,

Is there any chance for accepting this patch?
Or could you tell me how it can be reworked so that modinfo would support PKCS#7
(and LibreSSL)?

--
Stefan

On 15/02/2019 15:30, Stefan Strogin wrote:
> On 15/02/2019 10:04, Lucas De Marchi wrote:
>>
>> ooh, this ifdef is messy. Why do we want both libressl and openssl? What
>> distro is requiring that?
> 
> Well, in the kernel in scripts/sign-file.c the same ifdefs are used.
> 
> Every distro that tries to support LibreSSL requires that. I know at least
> Gentoo [1], Alpine and Void.
> 
>> if in the end we end up with ifdefs for N different libs I'd rather just
>> add the implementation in kmod itself or convince kernel guys to just
>> fill out the struct they are supposed to fill.
> 
> If you don't like ifdefs at all I would say that CMS is not needed. CMS and
> PKCS#7 formats are very similar. CMS is newer but is as much as possible
> backward compatible [2], but PKCS#7 is better supported. PKCS#7 has all the same
> fields that are used when a kernel module is signed using CMS (and otherwise).
> For example I can sign a module using OpenSSL-1.1.1 and CMS (even with hashes
> other than sha1) and read its signing information with modinfo and PKCS#7 on a
> system with LibreSSL, and otherwise.
> 
> So we can just replace CMS with PKCS#7 in fill_pkcs7().
> 
> [1] https://bugs.gentoo.org/677960
> [2] https://tools.ietf.org/html/rfc5652#section-1.1
> 
> --
> Stefan
> 

