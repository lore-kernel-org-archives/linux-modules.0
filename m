Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8522DECBF
	for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194856; cv=pass; b=eXShOOKKt6wZXkDzi04Si/gW6svskRy+dxnfWGKolX6DRTlMXU+QlXrSVdCfyAPPR+xXwHpdC13A/1m2DfGWplxIpZEHJFgKALc0YiiSzjTvrhfCes+y9zUzxNEGu/L+4oKPYhA/mjGHtFONaoT10rQaYKwGiBRJdnDvqz7f4KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194856; c=relaxed/simple;
	bh=8UJnLa/DDQ+b65RDSHa97nR/Rm6zetnRjswOkVb13wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byGraMQCie9pYDK7hyfJCwHVY6+oJ7d18FyYUD4bBwNC53+8/gHQFHF3kdMJE3gJYPTxGZa2ZdHRETsTevyL7LHCX2hAY3P8TZUDfnw+tebrl5xJi4Vj1Lk8SmBVyhVVN3qEQv7ELWcDfeD2EOtSNSbyNBwOa4aP39b6M7eyl6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SqpOgAb4; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqpOgAb4"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so9992849e87.1
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 19:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773194852; cv=none;
        d=google.com; s=arc-20240605;
        b=VU3++0l1cPeFJmVpSHqKpzfICrfXdCHs9w8svHrfLPoTrdJ6oSKe2Y2sSmBg96NryI
         M67b/LtyOstM5QAefryBu2kWC1dgu3zZCOLjZqCLC5HAgVMQAug6ETM37bSpgrTj5MUv
         QTIRzc7KxprLhZm6XypWXFFDDz+EwMOK4ItNnlzVvP5zlPX0FNdy0KAFucWJ/QvuFxG1
         LNZxjZrHgc4BBeqqmWsFUTW1PKYwf8JJqUg1W9JHumAeSEQYLJdDA3jgujRvWs0MIBSk
         3gFnIUqXqdlUCWjBbHTF+iMEessPRfcpxVjx+YSo/RGX3+8DzqVqrtiF/0RQ5YD1b4Rq
         5R/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        fh=FJEMeqO34/63CoGuHkpVkBx+gZbhXgXPh5VA34bHzt8=;
        b=IJ8oR9BQtjHzCibT3pY9YZI1R0Jaj7e7+XEO93N/FwnzKQ0W4TnTIBR+nfCASaRPJD
         +TNElng1U4SOrxfXYurDMh6h2xT3rA940kG17jD6YNa2xbf7iPrp+2N7vyGN7yPo28nv
         pqNBexErwQ29mocCs69cFfI3I7pD+hCo4ZMQb01aAkLBFwWWo5W/21/9/Y0kDH8OlHkY
         7ZWLwl+3uVAzcQqBTCZwB0K53jHLCtzC2xGigD5aLZRXxQxDEf+PMVeHNDq4GMbOlAe3
         kgcjnITu7QExPZRJcK4BnHDOhcu1pfqyhXVoRGOdXRUhzZvNF8veYuQQHrukl/gbrr9O
         ifjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773194852; x=1773799652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=SqpOgAb4CQOCp6QT1IhDiJXNOENCCAthmmQiQ2Xm1LqdH6AuNnr9pWEOxoaM6J2EHp
         TaZvrNsWvEAAdeAh3rGZCGLrxzU767HUy57VJt43+079ae3+2kuAr2+JBVbU8T9+l/BT
         vjjO+GANIyds0bGFgUhdgNG0FnF3NJi/nWQH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773194852; x=1773799652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zLBLQzKjcztDlxJqoLP6w+B6xnZmfHibV4jlBQCebA=;
        b=iQs/IcL7S4NUsu14qn4dyX2C9gK07b+FNNWOTFVWI/gH9wjmekCw28V3rms/uo0rsr
         IqySkgXR5QdeG69Zb46Q3euylUVsNQ9WurnXc2TbFOPzDciCHI5dJqEP7V+WlSmfvo1S
         ILUdyQwGj+hYLDLfCZlrJEfmH15CSclS4NZ6ZJ1RP/oOxNrXKHOhFy6wbgd1FcvXTyIO
         OjWBQlMZ8B8O3S3EgG87E1yKCRTQyrUHWC9eIfE3Hi4iZeB9m0a0OYDle6TWIYxnq18A
         d8E+bxTlS/6Yy6T1239hmliW96PXA8gcZ0IRNiqyTHPPEsHqkGakDGgLKu4eLmk66mgO
         6PXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPGNSo1zKzB/PfDGLpRdSxIGyexmSu5tHemAJeYbLvpwk6+lJtiCDfW6Jm0iYXDxkgHhwpIJc1/+6QNDBL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RGu9Y3oTeH19z1qI3+t8mGvLVSOpm9bFAs2mphgf/lzR3L+m
	krsqDpT2tmFV8+VjGcrawuOdulkeozIjymr7nj5JjezLK5Kf02tv80fSRKM9IuMy8w7RPK4LGmj
	19VcxziNb+m/CHxiyJDYp1zWYE0WEBF1xOITVkl4Q
X-Gm-Gg: ATEYQzxyCZrg6f1v9agIB1tRXApsGKMl8UrWn5GUHbA0pJdBSh78Ehsl8UpZ+xzVxLG
	K3P2oTJlQeTxVjV13G7vThy62wDJvcX77GIa/eU8rxW5pB6h9VWnxELR7RWTxib14VuoXncnpMd
	1TKZVodsZrGp7Ru5vG33Adv4PfYaWL5o2OkD7GQidSNvU2Zgz6nqzMKGWz6wpt18pW5cQCmg5JD
	x/7vp9fIvtBvlSv8Ws0ari5m9t4T/8hzbhb0ZWl++pz3uFqPIisFlTrKuN/g3YhQmvLFWvzwniC
	8Rk/fvMqcA==
X-Received: by 2002:ac2:4427:0:b0:5a1:3134:9bac with SMTP id
 2adb3069b0e04-5a156cbd1bbmr169453e87.28.1773194852284; Tue, 10 Mar 2026
 19:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Mar 2026 11:07:21 +0900
X-Gm-Features: AaiRm5028PWt8n-JnveiRgn8oYMksdR_-_nk4JOkvxMfplWs-GDr7RRk-OxICyw
Message-ID: <CAGXv+5FQAVaJjqhv+Xq-ysOc4SHQn2mCNTgCAp8XocmWBWGGoA@mail.gmail.com>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:57=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Semantich change: Previously the code only printed the warning on error,
> but not when the pointer was NULL. Now the warning is printed in both
> cases!
>
> Change found with coccinelle.
>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/clk/clk.c               | 4 ++--
>  drivers/clocksource/timer-pxa.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b72=
23d4488a9216ed1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
>         unsigned long flags;
>         const struct clk_ops *ops;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
>                 return;
>
>         clk_debug_unregister(clk->core);
> @@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
>  {
>         struct module *owner;
>
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +       if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))

clk_get_optional() returns NULL if the clk isn't present.

Drivers would just pass this to clk_put(). Your change here would cause
this pattern to emit a very big warning.

I don't think this change should be landed.


ChenYu

>                 return;
>
>         clk_prepare_lock();
> diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-=
pxa.c
> index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a=
4c0fb08ba11c8f9 100644
> --- a/drivers/clocksource/timer-pxa.c
> +++ b/drivers/clocksource/timer-pxa.c
> @@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem=
 *base)
>
>         timer_base =3D base;
>         clk =3D clk_get(NULL, "OSTIMER0");
> -       if (clk && !IS_ERR(clk)) {
> +       if (!IS_ERR_OR_NULL(clk)) {
>                 clk_prepare_enable(clk);
>                 pxa_timer_common_init(irq, clk_get_rate(clk));
>         } else {
>
> --
> 2.43.0
>
>
