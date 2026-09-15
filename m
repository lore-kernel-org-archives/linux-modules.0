Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01E39BFF1
	for <linux-modules@vger.kernel.org>; Tue, 15 Sep 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506571; cv=pass; b=P3/Nr3mCxv2Q6plTpZj+PPJp8Ki0ASs93K0QESThBDGoUlFZuzwstLPsX00JoQ7hUKBagnsoFvn4JU0J3rqNZnQtmCePwUXvq+LeywtrUF3LV5GkFUxzT9Uh0yZMYYIFp5x8YwOhvua8whT6wV1pcz85p6zjSyDosklYnmq/Hy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506571; c=relaxed/simple;
	bh=1QRE8JagBvXkhtro25uEoq7Fl1riQZiJGjJXvowWF9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCqRQ+Sg2QrsAQadN60vZyfSWj6osbHACedAIM1PwCNvyjrOrL7i3JGo85eJXHfNin8F4dJQQB/9gdZTk4Tc6nmE6vUJ+Qjj8oNtGVkfsm6z0qMEZtbYeLka12QBi1l8uswZNfHR2ZNCHimGjOpgqMUUFWHdxVy29DZuqWmYXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEKHDM6F; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEKHDM6F"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5306706e89dso23111cf.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Sep 2026 14:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789506569; cv=none;
        d=google.com; s=arc-20260327;
        b=jHbIf+PrvtcIu03EBaQZkT0wKX1Uk/6NR+7rn4Rci31Joehea4Fghw4KgrRVc9L437
         bEV7pCSasYPuJeIReDZZgNuGZ4UFdAvIOVNdbloQcyIgHFcFw17By6sDDmNYTpQ8pPCf
         rDiyFw1snO4En4h+Dcc0UgPKSGkqxIuYM3GPAbPJ6APxW8ChAUmM6Sxs8nk1Lt/bP4oo
         VE85XvivfJ8bcPn19dah9KC9MvEQRYimskFM+uxzkYLetCeOagU/UD4Wcu5qaD3/9lJM
         H23+q78gA9VYOLzGy2jXTRX6lR2PFpKK+Y+xl7ygfNVwFit/gJ6fXsjeYifnDb0oF2nP
         +Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OAM/MHo0tjYo/TgHknUbcGsVAWd3749MCucVMwwVJms=;
        fh=NylhX9fK31gOd2eTotq9JI32nV4HVAUBz2rjq8fIS6U=;
        b=AqSwxMAYxdAOjlA3vr9lR456XpkTgvuVyaH6thm7DylsITQie1RoiaBR2Z46U24hjJ
         0EXv9GTeL8gx0/fpAPdQ1kpOM/FuI8o16eYD7Edf7JKTVUGClur7AaiVU9lndAC3qP3N
         TO52cq9Tc3iWns9fHgLjkKl+2ssUVQoRnmY5CvYjNHECC2ykb23a2uN8JPBNB7JOppJ1
         brjBEd08U5zewzcnn2I4avqHL8fdhkFx+iBFW9Z6c00JkC9WPSr1xgsrH/Y9dHeN3oEu
         fHUzxhj5M1a9YkZLRtsLK1NAcI+zgneRrvo40Itu+wLxhRZJwc3P0I3nWb7NVA+QpAmk
         9PKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789506569; x=1790111369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OAM/MHo0tjYo/TgHknUbcGsVAWd3749MCucVMwwVJms=;
        b=tEKHDM6FifXwjFChe+TECRqENPdukEsPyRb9Ex50YFNTMwwTo6lTa27mxkxkEUYbGB
         gyHW7LFPO2k7FoJiraqCA70QZXHRE5jff3cg05yrvcs+vATQXBC1yLJWhitxMwyF/1kE
         cPJHdLc+AyhMvg/hwRauCuupEuVxzG8R73oOMQ3AziF2k5W4TjCGGftn4muqaTesk6SB
         nKaSGid6l7Lk9YW6oILo+A/iuqGXQEFlPo0BWNtwghj02TLreoyV9FhMknuBFR52cVX/
         noS13iL//5U4R/jij3Cvv0Ob403g9ZGHP4+9avqendkE7XgeqEeFFXzeSFXdCUDoDVHK
         pvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506569; x=1790111369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAM/MHo0tjYo/TgHknUbcGsVAWd3749MCucVMwwVJms=;
        b=ewtOiKd1rkrSr0jTj8ECFrS7GXdmT4sS6vCHz1KOjYTenM5/3JT3UohLdvVWCc38tX
         XsrcQMXzojxn+JL9TzCDaaOOVZ5Pgpv0UZvdHfYDT95eUOaZATWS8euW7woShJoKTRAt
         13y1Yy1l+jcZgfblsorAivH49mqIEJzuvH4khzMfwAwbuSb2vqV0typXXYXcZ3WePSAm
         LQxm8efHDFqPmOVPC5yocFFfmUl26QaSrsa0fovJl/ZiTofYTLKSnkfALAImOmb5EqIv
         0B3en8LPxUmTDJMhFhK54FNevECiqearZ+qTmjNoTMsiRKWT5Y1eLXN1s+r32qVDxtVd
         g8gQ==
X-Forwarded-Encrypted: i=1; AKwUvByg3bt9mjotmAaaqFE/pkfbjtCub898gtq417CuPuyE4C4iZ11iH0IdTlQ9ZFfKJqEH9CXFjQj649zgCeF3@vger.kernel.org
X-Gm-Message-State: AFuF++l/ngYSBkntwnKJGrSYHgaN76KkeKmhxIhRroHc+ucKFhB7EO0z
	LL5iJo6URNC6pNeNTzCiIq19ZXw1cLud+2XXe4hLByLtvIR+Rx0bPKnTI+PiQSizHWDDEKhuYvy
	Igkil6KTE8Ml4PeoVqFOww29xqJhYRyLKiWW7p5mZ
X-Gm-Gg: AYBFou0EcrHo9KlVRSf7ZLliTLTbU+NR3opVCpEKN2n1LChUEUaE2W2iglvpnPPMaFG
	EnM6YUMAY2LWavo3LcCu1VMSvLzSykptNOI1+HxtIumzj3IL5H3mLfYnZHjnLER4oaQSf/+ztpK
	E4u+RYOyv3b+BxPy5Ku5EcqhMSpEaXgfCPfGAbh52xoo8bz5dbcPsnrWiZPPOjzixXr6Ix7Je+F
	1sEAvjlVmfschlRHxIwbzSrA1ndSU17r2msTQkIIxGsmc2NOM/iP9Cy+8PsVrtPk6dXQj9mfiOj
	Al97tRlwdn2ASnntBk9qTFGi+hzmUTz0mefmBLWT66BWFrxWtskJglrDnoIloeuKhSlutCLLJWJ
	a3uoULnkH4VwpZebjGQgl
X-Received: by 2002:ac8:6f0f:0:b0:52f:9ed4:8d75 with SMTP id
 d75a77b69052e-5327ea623fbmr753851cf.15.1789506568256; Tue, 15 Sep 2026
 14:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Sep 2026 14:09:16 -0700
X-Gm-Features: AcwNN1W8v3TTrRxzwemLVzpv82f0jC7eBKsciqbn6XlLizQdqhzOL-UqObB-lQI
Message-ID: <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> The reservation is already stored in the maple tree when
> vm_module_tags_populate() fails. A failed load never unloads the
> module, so nothing releases the entry. Release it and roll
> module_tags.size back. Without the rollback a concurrent load that
> already passed needs_section_mem() can reuse the freed gap, skip
> vm_module_tags_populate() and write to unmapped memory.
>
> vmap_pages_range() may have installed some PTEs before failing. A
> retry to populate the same range would BUG on them, so undo them,
> but only if vmap actually ran.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as neede=
d")

If a patch fixes two other patches, it likely needs to be split so
that each part fixes one patch only. But read on please. I'm not sure
if one of the fixes is correct.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/alloc_tag.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe10..95ddf5b743d0 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
>                                      next_page, PAGE_SHIFT) < 0) {
>                         release_pages_arg arg =3D { .pages =3D next_page =
};
>
> +                       /*
> +                        * vmap_pages_range() only runs once all pages we=
re
> +                        * allocated, and it may have installed some mapp=
ings
> +                        * before failing. Undo them.

If vmap_pages_range() failed to map the range, why should we need to
undo it? If it indeed leaves some partial mapping when failing then I
would argue that vmap_pages_range() should be undoing these partial
mappings itself before returning the error.

> +                        */
> +                       if (nr =3D=3D more_pages)
> +                               vunmap_range(phys_end, phys_end + (nr << =
PAGE_SHIFT));
>                         /* Clean up and error out */
>                         release_pages(arg, nr);
>                         return -ENOMEM;
> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                 return ret;
>
>         if (module_tags.size < offset + size) {
> +               unsigned long prev_size =3D module_tags.size;
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                         shutdown_mem_profiling(true);
>                         pr_err("Failed to allocate memory for allocation =
tags in the module %s. Memory allocation profiling is disabled!\n",
>                                mod->name);
> +                       release_module_tags(mod, false);
> +                       module_tags.size =3D prev_size;

Yes, this one is a valid fix. It fixes 0f9b685626da commit.

>                         return ERR_PTR(grow_res);
>                 }
>         }
> --
> 2.25.1
>
