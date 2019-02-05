Return-Path: <SRS0=QLNy=QM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28111C282CB
	for <linux-modules@archiver.kernel.org>; Tue,  5 Feb 2019 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CA520818
	for <linux-modules@archiver.kernel.org>; Tue,  5 Feb 2019 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqk8AGJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBEVC3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:02:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44477 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBEVC3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 5 Feb 2019 16:02:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id v16so3387821wrn.11
        for <linux-modules@vger.kernel.org>; Tue, 05 Feb 2019 13:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SH9ubVtDziYJRecUF6er2wWhDpuwg78XldlJvDyGeTM=;
        b=Xqk8AGJG+nxDU+w9eFXRst3EtkGrCc7cx4V2qKuIsAGgomBS/PLM4T7DX7uUjDOMuE
         UW2lsCBkVgb0fKlo9hUv8yiZkQWen5z2AW9s1bAoBr2iiB4sKCKc9QbYuqK+qLA6EITu
         Htq910d81RbHuzApe6THxfpE/clsaSfL84qsss+q4ngCUXTrEDf71ZOA5Canj8M3Tzbw
         WF8vTyd3rtJchBf8CEdaD5mTfB4UaMhaYx2FTtvEjWIOvVuYol+7uUD54WYBm6dh+Frz
         8bMg4MDBMUM3QHPdHQlzX78tk2M2zVd3Wo554DwPaVXsaR+YB+toRC3uUZ8FWuL3GElg
         J/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SH9ubVtDziYJRecUF6er2wWhDpuwg78XldlJvDyGeTM=;
        b=uD76PaJjOkRzueYvsxyJ/4YYrkA2vYk+FvXVf0tXGlZsB/j4y/RvtICVyR6u82QFcr
         R84pjE67IzVvD74dlAZRqcPxVEokpNGnwyMd/eI+rd1WH/2zxELn4yFmPqZduCLT8TTO
         eLR07IGwtOjac7eliLYSrEcei2MR5yqhhLY7zSlJ6fSDRcueFS7zKoIy+IUSN1Sb4Pfs
         qciqTFB373R/oxqlH9CujMZoQjtQ5p2hF2siESUlEAgVka/RKVl8z70rs1zL4pqcRKGz
         efBr6lghEegS2gDm01e1y9H9ZuCOvFw5YkDmSo9pDRKD1Gmayu2S2eySzDJL9+u1RRkM
         vXGA==
X-Gm-Message-State: AHQUAuYyLiED5x0N49HnCBp9an3edfXfx26fqHCJpGne93/d1+wTRJx1
        9Vp6ik+IqTDqS0kPlO06ZaCnxMrdgbbDwnyUiTZkIBAB
X-Google-Smtp-Source: AHgI3IakiS3fJ0DAaJZuLtV7r0unQsXnf1U9smIl2a4ZByf0uQGgQCH8Rp/GEPYgAAXO9zN5pzEdn2nPd5lKjM8noKc=
X-Received: by 2002:adf:e34b:: with SMTP id n11mr4857374wrj.91.1549400547645;
 Tue, 05 Feb 2019 13:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20190201202002.5508-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20190201202002.5508-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 5 Feb 2019 13:02:16 -0800
Message-ID: <CAKi4VA+3oL7+CiEKNdHgauEtBG-+Y89uTQn3jT6Z9Q=N0mf9eA@mail.gmail.com>
Subject: Re: [PATCH kmod v3 0/2] read pkcs7 signature with openssl
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Feb 1, 2019 at 12:55 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> The same as before but with the test.
>
> I found, that using _cleanup_() is more inconvenient, since it will
> require wrappers for the types as for _cleanup_free().
>
> Changelog:
>
> v1->v2 no changes, just non-rfc
> v2->v3 test added

Applied, thanks!
Lucas De Marchi

>
> Yauheni Kaliuta (2):
>   testsuite: add modinfo pkcs7 signature test
>   libkmod-signature: implement pkcs7 parsing with openssl
>
>  Makefile.am                                   |   4 +-
>  configure.ac                                  |  11 +
>  libkmod/libkmod-internal.h                    |   3 +
>  libkmod/libkmod-module.c                      |   3 +
>  libkmod/libkmod-signature.c                   | 197 +++++++++++++++++-
>  testsuite/module-playground/dummy.pkcs7       | Bin 0 -> 721 bytes
>  testsuite/populate-modules.sh                 |   9 +
>  .../test-modinfo/correct-sig_hashalgo.txt     |   2 +-
>  .../test-modinfo/correct-sig_key.txt          |   2 +-
>  .../test-modinfo/correct-signer.txt           |   2 +-
>  testsuite/test-modinfo.c                      |   3 +-
>  11 files changed, 227 insertions(+), 9 deletions(-)
>  create mode 100644 testsuite/module-playground/dummy.pkcs7
>
> --
> 2.20.1
>


-- 
Lucas De Marchi
