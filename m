Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10920466B5D
	for <linux-modules@vger.kernel.org>; Mon, 24 Aug 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588815; cv=pass; b=NduyT4Ml5fVBPGuuuP8VYj6EwGZN3VWjWh73hulGee2ZefMWswTCPSKDqORoQOGUVovrPFpwBJk556zOji85a69t9sBodeGMS4mYp76pJDf0WybS5FgTtiwto2qUNfVlW5SHGEu1GFuxq59YoX6Sia/Ejl6nqpdgeABJZzbCZ5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588815; c=relaxed/simple;
	bh=YXQRKWB2V+T8ESPOJ2XFbSjXMS2trXCGCoVMfipD1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4ivhSRyymft/kaw83fQ3ovEcgxBNkZmOPpqYlfbuEYbxBSjCBmuMKkQfoffEVS2amiM159TGE9zPP7Zn3WTYH10xbV3g367e1rnPCMxSERPvJvnKkfK3RUcMH0yt8MjwLYcGA8lZgoGFvwHQ5Lbh/fPuilXkS2XyV+OUT5WNE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/ZgctKe; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/ZgctKe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c15a5b265so593011cf.0
        for <linux-modules@vger.kernel.org>; Mon, 24 Aug 2026 09:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787588812; cv=none;
        d=google.com; s=arc-20260327;
        b=EwyuvKcI2CQU64eS0oyVSjMV5pwYqhaISoFTqZOXB2/1ptDl10BGSvqb5WwCXGB8w7
         +0IEHvO1SgvjKm3R9zJgu0GJhAHdhYzPpRQATrDfEg8MU2sqbiotaI8UKePnctG4YNUv
         7Lnl+Gxv5fQ6BK1R3a+IRyhqpAXNfgTwhFwrWgr9gOrh7wpYlFbw/Sn3uog6QcEftPlh
         T9+kz7AdvJ6FowxMRhHZfF2osMzK+dBw0/qC6QLOojKxrqi26hc4HEPgnoMsi7EMr/sX
         YMZPdnpzOtHgKyAIc0XOvh0hoAnxdy0EAR0dNBDim6eV9bBEE0yyHL6F8EDS6Q5mWKbr
         9i7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5EKtL9SkX+iCe5X/rOV+4jxySIvKYwH338zXIa8baTk=;
        fh=2OtVnXlN88PHslqECumgM2nuq2XrbUDCjD2S7qC8j60=;
        b=oL4ay14pLPa0nuTffyNa6D8QGv/S4BMNTX5nIUJuaaXUBaFrAUnhpxP3eZWvAE2MKJ
         WygtnITDQG/EOd0sTy9N7P2yOjVllb1yqJ9egLdWoCuOwzgLkwEOFxeTT95iDquDp4EV
         H+13ad70Qj3I9mePiSTi93YHeAN/8NQ34nGGf1C4sulAXyXcJmPrJZRjGxPwITVRoLVa
         3xBH6BrA7o6MUrG7ioLPBpkHkKnj705wS4RxnsdwtNYh8MkctRrO5rQrBYun7y42RD40
         uFRImKCNjihDbggrLPkybXhos+SDpE9QMaIuk5oEYlDiYTUj/4sIq60edCtPGcX49g0S
         j4aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787588812; x=1788193612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5EKtL9SkX+iCe5X/rOV+4jxySIvKYwH338zXIa8baTk=;
        b=m/ZgctKeO3nbAr6t05kBRie8mhjcwEtmTBkavm2c4C6EKAbpXhKsAqMhYynPxknya6
         zRzhj+B9f9r5vmBEDdW2RrZobAy4rwaA4U3L0uzcAHqgfu5a1nPSmYjDOZaf41nEPcXM
         6eUCjgh7lwp7JQGZCkDTmnDNoY3Ow6AgHnc6SR+4I4EB9fHr07nICuvWHnD28U2YkrQY
         CkyDHqAjyIhJtyKnPMekYQHQwUfm35/qo42A4LnVhUDMET2lS45o9cLyKHEpBu6zk7mM
         Gom4popxTK2+6So8TLQYhp5wZRxokCj9DpX/2fYdoU4wa34UMdSBxAWzwp+tFiqH43ZB
         lt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787588812; x=1788193612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EKtL9SkX+iCe5X/rOV+4jxySIvKYwH338zXIa8baTk=;
        b=WejnUDgQHZiERsryCppEPogKYF20fArpJD0gv2GXx+5j4WNjs1Xd6Lm1QGlWTKRsYn
         9zEi8oafzh5GTZmOx/8+g927jNeQcSilmubfKtIYRCVPm+biWIvt12B6oLw0lrwsf0x4
         bHnLy8lYKXNQEsFXMb3l9RUgid6Y1iIxNUB5gu3cevOJg6AIzd9PPKDtDrI2/wqhIYuW
         JbEeT9vXSdXlqGGoH/8+7JoqlzeQDNXxkImbBZbprHK/7+qifL5Y0TxjfLwxqjo93Ou9
         2JJ02mJcoJb69tknTJS5ViO8NfzDSMpQqCgFs4Ey91g2hZJ+BP+OKRFnCjyTP66GYoCT
         Sx+A==
X-Forwarded-Encrypted: i=1; AHgh+Rp/Lw6IhHiEOjH/WFILGCROqna1EiA+9XlBPGJkWVJlh/7/I97YIFgE80ssGZNraE3XAARTbAUACEiHVP1a@vger.kernel.org
X-Gm-Message-State: AFuF++kzvPQTa7c48UHAGBKVdSv/n9f7D7dcI9ck7fvypd+b2PHpVM09
	jJwUDo8n15LuupBcYy5igKPjCtYB2T0LPGxP1i0bP5qykQqXRrIEh/NBefukJUDpGfJ3PnmlQGb
	iJxupvXmjaYF0E3qplDjjZgORgJurfKYhJdfAr3lX
X-Gm-Gg: AR+sD13g6xwCGwXCQDoi4N9rhhLu+cZWkO2flvNHm78f3uGW2AOHUIJjp2gJmKpK9+m
	N6nLUHD7soHqkCX3pf6YPEU/itpyp1k8Kod5xwT7KceSU8ayzye2U+oMjgWx5erxcWzGuLIAGEi
	TscA5ezxN+e/Z20FHLDO3Hl0cxD1jomHJYURYJuIOzDfy6FF9GDf5oQW3BC5wvqOCWa+t+lAX+B
	+OIGlmT4Mcbcf46uvE6ygm8GayL3QdHKqGha1dy9+DOkhc/qHJ/DujKveoJUjsVxPRDXiW/peXK
	T/hSsk0Aqlm1d4I/eGoqHnJMqSZob/upXWBrB+rLV2Q=
X-Received: by 2002:a05:622a:1f91:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52e0941062bmr39983391cf.6.1787588811060; Mon, 24 Aug 2026
 09:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824014736.35026-1-hao.ge@linux.dev>
In-Reply-To: <20260824014736.35026-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 24 Aug 2026 09:26:37 -0700
X-Gm-Features: AcwNN1U17Yy8Z5X6Y-Nyi5K74blzunXrSe6IaeRqrJ9yuxZaN3xLDsfiRO6rgu8
Message-ID: <CAJuCfpG_wQs776EU1bGfUyP8=YDgh2r9=AHc0TB7YjKKN_ksVQ@mail.gmail.com>
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 6:47=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> If codetag_load_module() fails, err is never set and load_module()
> returns 0 after the module has been torn down.
>
> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as mod=
ule load failures")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/module/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..afb810f0154c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>                         goto sysfs_cleanup;
>         }
>
> -       if (codetag_load_module(mod))
> +       err =3D codetag_load_module(mod);
> +       if (err)
>                 goto sysfs_cleanup;
>
>         /* Get rid of temporary copy. */
> --
> 2.25.1
>
