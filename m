Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5939F16B
	for <linux-modules@vger.kernel.org>; Sun,  4 Oct 2026 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136531; cv=pass; b=rYqYMXHuMDLRygzeHUF9t1Unw4ygRNyWwNzXgVPiYXvo5/IB22+zsK6JV/xKmFnqTnsFwI/EF0QXsOxASTG6IFHDkHcW0Zfha902BssK2rP0fQh7FHBfnzGNfphFOe5JdvFlFmF3c9fwUTi2h67uyjk/f0WNuhJ9kb9mwEJiMM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136531; c=relaxed/simple;
	bh=JS/DfHmzCQBktqfBDcLgWFGsP1pDN4vWax4Q2BX0O+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF3Jt8L0b8DFibbejamjIC8TOYs20KY/o+TsIwfSOhyf+GL8MAexWO0Mn7IIMyjkUA1HVp4Z3pIywDGyD2/EkyllFrjhQgOelBQgivI38pecc9GidCsGB98a+Ie2rC7J0M79+2b8rJdiKFE0OMhvKwSjtlDIfuswjgNlCuzfmBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eo7Lxbwq; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eo7Lxbwq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5351f9dbfe0so98391cf.1
        for <linux-modules@vger.kernel.org>; Sun, 04 Oct 2026 10:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136525; cv=none;
        d=google.com; s=arc-20260327;
        b=sTajNRNYlbZ1PffHBF3QTHzbOw9GQie/4wN8fNGdHzWT1WyX0yfF61Yx2f+PtUauwc
         EZdegPFAkVz7N6g+j72FBGXlHc6Da90W5GfyqVagBW8S8afRh6H7XxvVRl/DaiL7ri4N
         kP0i9cfhVN9yJa2m12sPmWNOVVFMf8baZLTWNtPVIyzdNII4+d7ap9+lrbRPt2K4+vap
         D8l5I3OwJDUXQ289xBqRWQMlvJo1xuXFtp/ZH0xlLFLclmRZh9VHIEAisd2fa/ke+ocy
         Yndu10Q6ERI/J0kNrLS45+U7CpuLOPEC4Hk2vUlWgaZl6uJYWVYlNdZpnYZBFUw78LiH
         do7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFRiHWm52m67lLPZ4QttIFc2/s9ESzUdGTCBMadUb1o=;
        fh=y/PkkDr9/qJM3EzMUcdNSqEA5+7J2EIjjnMqlMv/908=;
        b=B3f7KiaLvHgd3Ue/mIZ4EHJGPFNGNRFoXYEzJeQCnhpPUXz546nSXuiuUQozE87Bvy
         mcb5pHPEVdvDcpKnDQv30kCLcnwGnt72CuQEcjm3sm4223lGaSzvc9dY9jLqXShOerOD
         zeKyboGeDwMEq03HyTP8EqlYH0/c3+59lhlV9bcAUeWRsp1o0kTW0mHIyr4txrCREY7X
         +S6a2lT4MhnSK2I29qmw6/Uplnk+nvsnqw0LZEj6rIWG267+EZJjJt4Sdo7UhplAV/3t
         kIy6HJ/fvBiSbsXkQlJPx3FmA9pa16vTJEXT6f7GrScQcWgdw6lSRk/vKq5yEzK7miDE
         T/jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136525; x=1791741325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TFRiHWm52m67lLPZ4QttIFc2/s9ESzUdGTCBMadUb1o=;
        b=eo7Lxbwq+tvykVl3jsl+khAQDgShQ2Tccxz+XQGYPbszWI5v6dRbn9UKzEjJ7snPhZ
         bc4wjz2ApoF/eY3f37u4KH0OOxFVgIB3VIdirmzC7kKVpG4dSygLMlbny5EMLja16fw3
         GBP6leu7UZPutM1QXufrPRm8hLdOws1SCk6Q5l7IikMQkl+u8NbKtWUjAhEVof70x16u
         daDFFMtqnK+tlrmiKN16UdbYKHLSdP8YcnMWEb9o/Mj3go9K4sWDPUWUq93kMW2Qxae9
         GRGxJH9i5j2TKyFo/C+ycnreJwp3KVdAZI6mYzAshvw+onBYLswzrYrNIPj1NPxi80CV
         sRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136525; x=1791741325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFRiHWm52m67lLPZ4QttIFc2/s9ESzUdGTCBMadUb1o=;
        b=hnYVhVo6120m5jJ/DZ4gZgOoL8O/W7dHdvuhrwaAlZtR+7TmXgKki0Nl2umxywNB3w
         Aq2+F3gSNHVqiE0NNgByVGPzrLBa8ud1nG9SgGtSGAbWP6iS11vEtno3+Py8Et90VJLC
         vbK4CL0YePtUzWBKu+xpgwMe7F8E3OkoUTwLzJvV4ns5qmhRyMW9pW0Gg576rIO/ZHGK
         ZdL4EEw/R50tr0QavuNOaWfoKqQ6H3UsS9s3nzT5QKUB8VBVOuqxzJT7qjWxchSIo1z7
         mWPGbEWHLwtKzKvOR6BbPgcEhBTS+gyD7myoYDzq2Ai/uin+29hdpxpToIePaaPosB+X
         k7PA==
X-Forwarded-Encrypted: i=1; AKwUvByIysuolyew0rsXwIniwuxYPCYgrZKE+Fn8tYWhxvGKY+hPrP5MijSMg40eLqPXKTc7UbxzrPJcouvP9pOz@vger.kernel.org
X-Gm-Message-State: AFuF++l2QmonCIVkmb1cMsheygH3YcJHbid5F7oRifOvciEqiBMTZuo9
	9Rdp2uURq/RRUDd7ETh3pfTrAQ+b/X+1k70KUnmBL+ianZaa9P79jOTBwy8fxVWmiZ4lWrZJlyB
	MlLheK8SigHodQA+Lc2L4Ype5tFu6/LiJDp5Y1neV
X-Gm-Gg: AYBFou1jOGO1FsaCtTaRGpYY8tfwfng+rJlRotOC0hbPdxKmz8fLpmGDLjsPb9qI6W8
	20N3WP7USojntHExsHG0xuGa25ubzFDgC0GI+Mm/PkWld6C/rRGSsGx6QvVwcUsmIP7DdLnTuSc
	a1yRNAmdNQl/lDctJUEfj9xUQfN0y9ixp4iWBDEQWRnw2eW2aItuMq2PfHeUOPJ74NHYf31pXXm
	lAzFPv1Y3d2uI9RCGBNSmphsntDiHb8X39ribJpGCAhGyePJEtx8SuHGUMbK1dV9C2SQNmCeZ03
	/w1Lf5c4iLqykzcHODbnq01tm0+eDcvunR0DibOS/2/ELawJAWT93Y9yppqNvCLC/rs=
X-Received: by 2002:a05:622a:191c:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-535146541aemr3824271cf.2.1791136524268; Sun, 04 Oct 2026
 10:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929082014.160587-1-hao.ge@linux.dev> <20260929082014.160587-4-hao.ge@linux.dev>
In-Reply-To: <20260929082014.160587-4-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 19:55:12 +0200
X-Gm-Features: AclHuK9GuJ1R4AG2eys0TOfTlndz5Q1KT7n5Xy5IteGOVBALshKC8Ehhj3tDVOw
Message-ID: <CAJuCfpHXT41Y3N70xOF3MXtZm118-mR2DuXP=vt1M+TuMG2Uqw@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>
Cc: "=Kent Overstreet" <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 10:20=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> The reservation is already stored in the maple tree when
> vm_module_tags_populate() fails. A failed load never unloads the
> module, so nothing releases the entry. Release it and roll
> module_tags.size back. Without the rollback a concurrent load that
> already passed needs_section_mem() can reuse the freed gap, skip
> vm_module_tags_populate() and write to unmapped memory.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as neede=
d")

I think 0f9b685626da is the only one being fixed here. 4835f747d3ed
contains the issue simply because 0f9b685626da already had it.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/alloc_tag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe10..3e6306ee0764 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -947,6 +947,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                 return ret;
>
>         if (module_tags.size < offset + size) {
> +               unsigned long prev_size =3D module_tags.size;
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> @@ -961,6 +962,8 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                         shutdown_mem_profiling(true);
>                         pr_err("Failed to allocate memory for allocation =
tags in the module %s. Memory allocation profiling is disabled!\n",
>                                mod->name);
> +                       release_module_tags(mod, false);
> +                       module_tags.size =3D prev_size;
>                         return ERR_PTR(grow_res);
>                 }
>         }
> --
> 2.25.1
>
