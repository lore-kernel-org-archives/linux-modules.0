Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C59286896
	for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670610; cv=none; b=aN+Gzc/AnZBRLp8Hm+f9OZkhEwjGVeVCXu/8cvcxd61o+Rr7diKNusXaElLDqWgYMNy+bVAf3heQXgOivwk+9HEBWGEAI5fo1dwWdW3QJa/MXKBh2H6RdyZnkDEsfyAGt1F8VSz+CeUVQdGQsFiXlCVJudlkuBblbkYakHA8n3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670610; c=relaxed/simple;
	bh=qfosA1+czaieYstJoGp8+CfQqfn5uNyaJNphjp2Z4Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqqw/2gc6rVrS6lCbY4W28dvJ5vkD9QqpJgQDBijF6DFYOKVz1S51aQc6XyIUBSN2Zsttmxph4koOhQQC8pA8StgBR2sJFOl55I4kPEWm3ulwYkwELIbmJUdn4kQJnVGA8zj/99wnCUVBbeh3txb75zvCXI4cVay80Q5XFiUYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aS8hs0wH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aS8hs0wH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47666573242so686391cf.0
        for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747670608; x=1748275408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwFo7rvRgNULrT5RtzzDoxbCBW4PYATrFYKV2nFZanI=;
        b=aS8hs0wHBm/iT2/IpvDgewubKhbYl3NyVllQ0DK6nJ9jiV72kHjBIBVJINKsLbcW4/
         2TWZz+uodEOG+F8CpEVgDpSOyeggX6sZyGHQCi3UvTw3jmQXUJWs2RJFr9bSip3TBKW/
         fes0aoGzS3YhAJbqVRD44/SDb7/i0qe90wDGTn7WjYTxSZJ1/jDWMaTnVrVbR4bdJ6Fn
         0TVZ+wMQY1TT7iEcLovpQUKIb24HACseLSl7DdoVEKzaQ4MV4yFn1oV6vj8W9O09mQxd
         TFfxFncgbYEt6VWdMM5BR3VCBvBErmHOl2MvG6IS1diYQLKQSE7GvFDKz3NbrjJNPouY
         sIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747670608; x=1748275408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwFo7rvRgNULrT5RtzzDoxbCBW4PYATrFYKV2nFZanI=;
        b=wIbeWwS2rFHsd3+7rfWz7XvwwEiZQr4f4BwDcuprqiPBOya45o/Hupd4apAEXF+66T
         OQTNEo4CL7gmU50koTUkJ2DmEymwh44M7MAPH5Y/QTvdSJSqmMmuDYIC6DSIcxxHyBPZ
         Yl+6ZldiNhcWHqsCmUi/ZLcfHlNdz11NP/P95wzha/usSfYhdZgvprxolYMBgInvuTJ9
         r/fJlNckeBG6ai910fkXbWYX9QQZWfeQD4aPt7kU46AqU1vv/ihTlBxDu4Nr4f3S+skq
         J+o1MG/Yg/oNaL2HOpioVow4gVYzzvu3Heo2Ul02hxc3Ee3Gd2ynLT2OmH0Rqe3tFCmb
         f35w==
X-Forwarded-Encrypted: i=1; AJvYcCXIDIt30uw7iZDLQcMw18BTX9fDT6kD+IC1O4mBm/6/uMevs6m+4MHODNi0o0dl9RDgstosyWXRBmAdlDCK@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9YpeIkAVvJfbaUMjsSnPJCDV69Oh2BCcwjEmoCABt6FPu17L
	ZPJEbh0CrnmSKkZXYCEWMcn04aoz0+cgfeC8JYziV8Ndqt4y9x060UH+idOe3j3DNcQQgdn/e2S
	ohmrI050yemJwP/Gp3yHL9HeNNqaHjZ4L1rA72zG9
X-Gm-Gg: ASbGncvR6zelbBHCZOhg+Vwix5TwVX0mtbEDliaM1r4BFr1FbI6RKN1CMJh3IFfa8fy
	L+JjCF71JZAT+j4/rUUfmes4sZfwtfhk9zdZ2n08ko6Zke0W6lUL38OQ6cApkzduuDbXdrVw1nx
	QK981IsEO+1GS2xFCELfsJSsIKVg/Dc+a6lYvmRfXPMg==
X-Google-Smtp-Source: AGHT+IFjOFo+QFAwm+vxGHsUhwf4M00RZb1Cl72fJqBWGIrhqZZm3lCaA06XNasSEqb51z7OdnA5j7D1iI1aERKQ1so=
X-Received: by 2002:ac8:7d0a:0:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-495ff7c853fmr6292921cf.3.1747670607520; Mon, 19 May 2025
 09:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518101212.19930-1-00107082@163.com>
In-Reply-To: <20250518101212.19930-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 May 2025 09:03:16 -0700
X-Gm-Features: AX0GCFtzR1oBhFGIyDxznuUx7HQDG0rFycuh7HxGmy0Ebdyc64y5ZoZ7wYq18bc
Message-ID: <CAJuCfpEeo2qKcyan9BnYGvEaYeso24wQT1eX-CxnBkjbEuY7sg@mail.gmail.com>
Subject: Re: [PATCH] module: release codetag section when module load fails
To: David Wang <00107082@163.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 3:12=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
> When module load failed after memory for codetag sections ready,

nit: s/ready/is ready

> codetag section memory was not properly released. This
> causes memory leak, and if next module load happens to got the

nit: s/happens to got/happens to get


> same module address, codetag may pick the uninitialized section
> when manipulating tags during module unload, and lead to
> "unable to handle page fault" BUG.
>
> Closes: https://lore.kernel.org/all/20250516131246.6244-1-00107082@163.co=
m/
> Signed-off-by: David Wang <00107082@163.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/module/main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a2859dc3eea6..5c6ab20240a6 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2829,6 +2829,7 @@ static void module_deallocate(struct module *mod, s=
truct load_info *info)
>  {
>         percpu_modfree(mod);
>         module_arch_freeing_init(mod);
> +       codetag_free_module_sections(mod);
>
>         free_mod_mem(mod);
>  }
> --
> 2.39.2
>
