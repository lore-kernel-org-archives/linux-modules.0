Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095636AA1
	for <linux-modules@vger.kernel.org>; Wed, 15 Jan 2025 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911269; cv=none; b=ZPAK1g8sP/WTdtTlx4gP2P8l3VeDdvCShcAg0ICRz8+WKxCL4Cgb0lab6j85DPum6e8uZR0+E1gl5o77GFyCxC+VzrCHMvUiUCqQUL0dicW6+VytZuE5jbwZunPvjv8e3o87vpgMryInBi0kYj9kBhSbVBcNvGWe5x3vMmTV+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911269; c=relaxed/simple;
	bh=vZhZ5mpU4ARFAU21Q5Y3XX02yM4obnDId086vB+XiSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWfo0xXoCXzw7sgsk3IoBa0AulpbWOm3AQiD6740yz3Wwd+9wtAEN3zVJAiPB25JMSTflw2IYr9rL9RtJ4m3T75c0+Od6hKiG98XZxZH4Ki68NreTEFWHnKrtFeuodfskVZy14NDsPFx2GtbKamEbmQu/zrkfcMo8YqvDO0lI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f7nMiZNh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f7nMiZNh"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso9828846276.2
        for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 19:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736911267; x=1737516067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PAbt3RoqymzKIdE/iy6KgDkwHjpspEN29sJOxB3QU0=;
        b=f7nMiZNhRX8SbDlQsWJE1snMWZ0i87p6WDnJoYfo9kCQw6+wgFsbUPh/A2IE7dVMjW
         ng9P6Hx399/nReWIcm/o4M9snyXDRWz5y3ztDjSbxoDiTqEIvOzsqKB8wmuztVRr3fcc
         LKGoJpqdyhUIaMJf3aSCkQDrB/7f6Gv20CtJ/KYJIHhimmNs+6chFF7QV20FB+eLctYr
         DcVlYMM/55OxwPqB5oE8HogZOmKRtO28yRQ+0yF1wkLka6VlTJTtj59kNtylAXh9oZof
         TIRvEahSjHybQZCDruIypDG3ADCAeXT5fzEMD8BQrMPdVbYg5iEwUrpO5i+cDBQstIrI
         lyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736911267; x=1737516067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PAbt3RoqymzKIdE/iy6KgDkwHjpspEN29sJOxB3QU0=;
        b=bmJBhNjXplXzhZpVmus3dPcUXSxBGINUFJA2A648MoHBf6rDs6jClU2v9/K6da39N3
         55r9mjzMpqb+44vSq7R1WyYjY4gCYDq5THNJiP8JYeMqjDoLNEBqUht3VuiBlgIBxtny
         +xHOyAEoHr0llnHhMBsXKzAAiEC0lOTVrJpQDxkG4/5pdOh9dRMstGDNxklYFIAAIpNy
         JpPIK71aNrs221zDGiNH8m4vEgGQnyyETEA//+GnYmCFp+xuwE+55xL0g8OUtNtZwOAs
         oyKH8bXh7XfsbhSNV4MjQxsyRr+eM/tQ9Ytpn7AVv0MfK/7fUKLLgT5q1hKDAl96/vP6
         /xxg==
X-Forwarded-Encrypted: i=1; AJvYcCUSeEDgr5RGIZlK4wOJyO84UpujJDxktvcd8ff5HX00AGE/eL8kNtKBz1z+cUv9IZo3X55UBdYREzcxnx6e@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSmElaBq/Yh88azFVDl+ejY3pCgPuead2nzPrGvcZZ+FAkpUs
	R1YLw5AA0h4saxqxpYpGcA17oxHRFKrKt72PR2IcQe0w+FL8qBOu+ulYAZO/unqOnN4XPo3D9Rp
	4C+kp2PFRKb2/e/WeCj4mgQm3ljW4LGXB3JH/
X-Gm-Gg: ASbGnctkk/CyDEV6WQUI7FjWCC6rw8u/Yf2DuFekMJJp/M0lRFECChoYv0rgB7gYIW6
	Tp4w6yy83JYSjdtag+YVF/k37R5ZInhr85ySU
X-Google-Smtp-Source: AGHT+IE+pU3FjGDuUPG3s7G5wQl4Man37elNd23EQMeLmM2CayVs/+p7SpZCIdW63ux6ukWZkXrCdNhKOphxf763K4w=
X-Received: by 2002:a05:6902:a84:b0:e57:4b07:66d8 with SMTP id
 3f1490d57ef6-e574b07696fmr9605552276.34.1736911267021; Tue, 14 Jan 2025
 19:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114161729.77142-1-arulpandiyan.vadivel@siemens.com>
In-Reply-To: <20250114161729.77142-1-arulpandiyan.vadivel@siemens.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Jan 2025 22:20:56 -0500
X-Gm-Features: AbW1kvYzRJp2SIHBD89SpPNhaiUeT1UPEpERzLDRoqPipF6Jtwt_Cn80F-vDsFU
Message-ID: <CAHC9VhR8Ny3McMo7ZDw06ry0VdUHEQcym8yvSJHdYdUUoVMAKQ@mail.gmail.com>
Subject: Re: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Cc: linux-security-module@vger.kernel.org, linux-modules@vger.kernel.org, 
	cedric.hombourger@siemens.com, srikanth.krishnakar@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:16=E2=80=AFAM Arulpandiyan Vadivel
<arulpandiyan.vadivel@siemens.com> wrote:
>
> Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no longer
> available from kernel modules.
>
> Fixes: c7ff693fa209 ("module: Split modules_install compression and in-ke=
rnel decompression")
> Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
> ---
> Changes in v2:
> Reword the commit message
> Modify logic and add Fixes tag.
> ---
>  security/loadpin/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For what it's worth, this looks fine to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> index 848f8b4a60190..d82bcdb34cc8a 100644
> --- a/security/loadpin/Kconfig
> +++ b/security/loadpin/Kconfig
> @@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
>         depends on SECURITY_LOADPIN
>         # Module compression breaks LoadPin unless modules are decompress=
ed in
>         # the kernel.
> -       depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS=
)
> +       depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)
>         help
>           If selected, LoadPin will enforce pinning at boot. If not
>           selected, it can be enabled at boot with the kernel parameter
> --
> 2.39.5

--=20
paul-moore.com
