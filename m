Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PIjRD6cP"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E444BD
	for <linux-modules@vger.kernel.org>; Tue, 12 Dec 2023 12:11:51 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE2EE3F182
	for <linux-modules@vger.kernel.org>; Tue, 12 Dec 2023 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702411909;
	bh=XCa0E1lAm2n9GmItdGOx9YyxXLG2EmQaxBESWwE/rt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PIjRD6cPzJqG9dCLUkbVzwpBiiDhsBITKlU+fD6O6dCroqVhYbdTI/Zr/3h452TaI
	 BbYJLSXe4XHieAJALvkmJJ2Ot8lLWjpG5mGm/bP9/qHO8HzV7yJ00wwR5n4nBBGbdH
	 /Q/or/NfPMzApL6M+AiD+pKPZY4rh62mn9EGy/3zjCLmcVkky6zihUOJLg6KKzeCR2
	 g3ZXuLMA8SHQQxU50QTNwT+Qm3gEL5dCqq6e+5M6LvxSCrB6SNWMrRCCZglKqjZO/U
	 FSouP/smBCCdoTJywzvC4vK/eVwV7D0nAs8ArI+hflhXEDu7oJPm+O5IZZgebyFx28
	 wslZXQrL0fVkw==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33349915da3so5114301f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 12 Dec 2023 12:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411909; x=1703016709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCa0E1lAm2n9GmItdGOx9YyxXLG2EmQaxBESWwE/rt4=;
        b=Ro31Q7xbH4vBO8y0JQuxTwWT4N+XtkD3fWir/Jdw2x9CP5d6sJb/1PhB6rwHpZT1qG
         zSIg+xWOU+Gh6DOI+lzQVaBzXYMkHOPRhnAMksZTnfVPW1LrfGv0atrZhZp0SThy33EF
         DKCqgeRfidtKFCLOuPbrVmpLheQgAMuNcTGZ74dhDA/PnC/865R6byPr12VWZD+c7VNa
         MeftbtSCy3DdDtKTd9pag93iOWBuoLNZu84O0/QXIKlfccmWdh2DhJGG0W66drkmq+jh
         t3GKvZPnRIf+ijO1Xj3FIq39CqB/smHaPo05DGkNQ0VwlVXF/mKg/ZdFtMKLTPPfECU5
         O5/Q==
X-Gm-Message-State: AOJu0YzlHF6V4pYgpcc4R+TXloXNvtcKhBob43OXn0fJAFHAqDyqu0Yq
	ha3WQxQdqi8OmvLWCJfT1J9J3RsVCLUN4S2NsFcWTs/IF3IDBEwbuQz1lo+2lol3Me1x90kFV12
	gQdPAdYdT1i4RH5fi1c24+wCqHFnZ7zvAzRUzcD2OB4IOM2hnzGLEsi8S4OA=
X-Received: by 2002:adf:a187:0:b0:333:5eea:9217 with SMTP id u7-20020adfa187000000b003335eea9217mr2212526wru.15.1702411909528;
        Tue, 12 Dec 2023 12:11:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhmKIpLxUdgrrQ7WvAqj9XuAH88VskEZ2vXPeTEaBOCGCHJeypSS9MRtj/seSY7yK88LhhXhmDW9DzgkLYMMQ=
X-Received: by 2002:adf:a187:0:b0:333:5eea:9217 with SMTP id
 u7-20020adfa187000000b003335eea9217mr2212524wru.15.1702411909255; Tue, 12 Dec
 2023 12:11:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022180928.180437-1-dimitri.ledkov@canonical.com> <ltdfl4l32ht2oimlppyml22q7dst35i6m4foklamapoykkl3ql@u7qmh2aa4abh>
In-Reply-To: <ltdfl4l32ht2oimlppyml22q7dst35i6m4foklamapoykkl3ql@u7qmh2aa4abh>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Tue, 12 Dec 2023 20:11:13 +0000
Message-ID: <CADWks+b+wVxjE4XL750V9qFWN7PPn0pE_1-sex-ZSHYdcUQJ2Q@mail.gmail.com>
Subject: Re: [PATCH] kmod: Add FIPS 202 SHA-3 support
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 15:26, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Sun, Oct 22, 2023 at 07:09:28PM +0100, Dimitri John Ledkov wrote:
> >Add support for parsing FIPS 202 SHA-3 signature hashes. Separately,
> >it is not clear why explicit hashes are re-encoded here, instead of
> >trying to generically show any digest openssl supports.
> >
> >Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

NACK

> >---
> > libkmod/libkmod-signature.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> >diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
> >index b749a818f9..a39059cd7c 100644
> >--- a/libkmod/libkmod-signature.c
> >+++ b/libkmod/libkmod-signature.c
> >@@ -57,6 +57,9 @@ enum pkey_hash_algo {
> >       PKEY_HASH_SHA512,
> >       PKEY_HASH_SHA224,
> >       PKEY_HASH_SM3,
> >+      PKEY_HASH_SHA3_256,
> >+      PKEY_HASH_SHA3_384,
> >+      PKEY_HASH_SHA3_512,
> >       PKEY_HASH__LAST
> > };
> >
> >@@ -70,6 +73,9 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> >       [PKEY_HASH_SHA512]      = "sha512",
> >       [PKEY_HASH_SHA224]      = "sha224",
> >       [PKEY_HASH_SM3]         = "sm3",
> >+      [PKEY_HASH_SHA3_256]    = "sha3-256",
> >+      [PKEY_HASH_SHA3_384]    = "sha3-384",
> >+      [PKEY_HASH_SHA3_512]    = "sha3-512",
> > };
> >
> > enum pkey_id_type {
> >@@ -167,6 +173,12 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
> >       case NID_sm3:
> >               return PKEY_HASH_SM3;
> > # endif
> >+      case NID_sha3_256:
> >+              return PKEY_HASH_SHA3_256;
> >+      case NID_sha3_384:
> >+              return PKEY_HASH_SHA3_384;
> >+      case NID_sha3_512:
> >+              return PKEY_HASH_SHA3_512;
>
>
> with your other patch, libkmod: remove pkcs7 obj_to_hash_algo(), this
> hunk is not needed anymore. Do you want to send a new version of this
> patch?

This patch is no longer required, given that
https://lore.kernel.org/all/20231029010319.157390-1-dimitri.ledkov@canonical.com/
is applied. Upgrade kmod to the one that has at least that patch
applied, and then pkcs7 signatures are parsed correctly with
everything that a runtime OpenSSL supports. Thus if you want to see
SHA3 signatures, ensure your runtime libssl has SHA3 support.

>
> thanks
> Lucas De Marchi
>
> >       default:
> >               return -1;
> >       }
> >--
> >2.34.1
> >
> >

-- 
Dimitri

Sent from Ubuntu Pro
https://ubuntu.com/pro
