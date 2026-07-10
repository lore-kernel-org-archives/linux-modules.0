Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB8435ECD
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698209; cv=pass; b=eRoTtLy9F7cvrFlkmmkmAayFjyezffqg/l3nDq2K9kd5/p2wsmSZcUX+ES9ZRA/CXtNVsPnxrhspuxThGjJTq/znYegZ726s9tyDToT0xvUOT356Flhh2Bji0MsQaqsVqBP1IRV2hGbtyESxRXXTpCA5HxAc/vc388HDVK1o1XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698209; c=relaxed/simple;
	bh=SIP3TprJxk9f7sZwXPXIEhZyUNkSDUUk4StLKXdW3xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiH4GF0zWQPbWkBz/DUSp8wAk9mTtizGTOSGOhPq6yL6QI2wukPOqZz0F1Y9WEIciZl/HTQ6Wdz3bGlmnaef0bfyQOo6OYNvnpd8P3i+8x9f5ACH85e/Dj9ynj43tiQzJSAoOSEemoJpS5Cj+Bogrii0xIlnTd+0iioYzsrpRyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9qCgyR4; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9qCgyR4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c01c79467so363111cf.0
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 08:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783698206; cv=none;
        d=google.com; s=arc-20260327;
        b=PGtrlXrI76QqijejG0BVbJJG7nDd+xDW+wPnxSFD1eaHrrBcje8eGxoWbEvxsjShgR
         WXp0RCJh/dwHGVesD7sESlq5J0GtWYDtzGs/RCEMNk/yMWnyLvIZYjDES9deytdCbCT/
         R1+fb4SdPMuWq5/sElu0VY0XBSumelrdimYuZfjiFPGCFzMUQEBIvJU5Tin8VXLXsdSP
         AsPwi2W6ZtNB+fKp3l86EwNVdpQ9uxwFocC6RJEuo7Izkk21sxtc9x/AVojdzWsAQPWH
         PcbZEBGaWbh+HJN7FonGry1/F5jfdSGwzoMYkAiHysgugGFlbxHTw2D7TTbMLTXvix7M
         Bu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eiWuhZx3fx/3kwPRGWti1RYKNclAJ7EyzHkbsfNA19c=;
        fh=nf35qH74jKW/i3TFZ+dwDlp6e+Bx1CLjByfsMsqNaMk=;
        b=cdwXUR5x/AB3l2eUfqJfvrnCFW2u4EhkHQaK+pQH5amkePlvxN66435NmqYkYk9XXy
         Kqo5NR6dGU/FpUFEkVn5dIVHF5WPGd5Nd8KpugVrw+2+TpVu38h0NBZlV0rbW88DGh1k
         UkSIkSBt0k9CwQ53qcFFpEQwmM81UlDJWUHMRbEpTZueMQXKwQTrLALbPJk6rzYYsFf0
         2YpDKKBEpAYYfm/HKbvRnRVbRoXlD+Fg/LJFpyLOm4f+ubNQh9aQdyVO2pgyw8Lht5E9
         MyAFtCUu2AMzbpHcmYlcMBYBixtx/sZ89mTa71JK7pp3waABl/5xrcK1jcjXVFBDChuc
         zZxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783698206; x=1784303006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eiWuhZx3fx/3kwPRGWti1RYKNclAJ7EyzHkbsfNA19c=;
        b=j9qCgyR4NGWJlEPkgXXWxToAwmFJRYNqrWHN7j9Jmo02W4IloIsfcd5L4rH7fTKc+Z
         1Cm21MwOyHLU8Yivb0xABmjkht4JOpqIoNnpjB1z2FRzYxyZKxaaTNlHWPMmhIfQDMy+
         DVp79hoz2o1nOn4vCxsBzF988uWtrS2VVtUXGkIdT935+zhiVC3tQCvx4CW8zo7vxNa8
         HZBrqOxfy7WEosM8FKLmI9GC3LJ5OhvdJVHUgOdfRyYjQi6KGYFMjnJd+Kc6fFRZ9hod
         JnN4n7OYCKE1u6zGH5kYy5PQoOgWTyX5LJlEWL/CVtTH6H+Ika/K/7mEtlQPH83tBt4A
         0gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783698206; x=1784303006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiWuhZx3fx/3kwPRGWti1RYKNclAJ7EyzHkbsfNA19c=;
        b=LfZcxDaaHh2mhnyKZBkOH47tBEhPjyAQPENFBuNvhEGkzBSRYQxiYJRtrv/QN/uxtq
         FA1lhEH2t1Y45UyXTkOmtYsKN2uUNqkF0q//XOL3yHhww34nLHUwy35wSuXqwETnkUR0
         gNsQ1TLXBOmi9TcHeDK0zZ3oUojcBg3HBvBlI8My0WDBfq3s7Em+gGC+8IF1j6UH7NU7
         AgaGAXM/qinXGDKKfNbPJQU8LYpZ25WFkaIU3HoLX4I5V55O/hic8dohltGIr1+qm6X/
         mBrFRRDsbVSc6HSRYlvd5QyE+Jezs1qjQXyFN7KOrar9gbW0Jafvk8lVUY6Rum9+E6Yk
         d4Vw==
X-Forwarded-Encrypted: i=1; AHgh+RoTaBFuob1geleF0IEotpFdB6h9h5e7nP9rKK8WZCRKors4s96N+rkV7Vtu55yAtw8x9dxCIhgCrPd1cgBl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cHCXhtd+cdd3Yc5X99ciumIIqS9jMZRdmR2kHN8PdRcayI+n
	LqM7T3sjS/0V4mcNqLZqFZ6Mti7pmrGxjjwyoPZSFqMHGvYPV1Td14ON+4EDoJWuY5IJ/U6gv1L
	CWANrj0tbM25oqv3IkG2JpCIOKwG1Zj0rI4KBYIK5
X-Gm-Gg: AfdE7cl7ald94u/wzn2zW7EymoKHg84fDkmic+hubtk/U9WsfHC/egOIsaIfmiIQpQ0
	zCz1meez4kDAx8HhWPBuh0yLg9DSyB9cjqmABliEHIYjF7rae8zb53k0KBO+wNifVDoXlo8Z1ja
	JhRuZeAMFEO4D4ShAf06oI/hnyDkLKywOf0pnJ8UQ15kMkhnz9CmBLVSr7gN2pdT97RWquhDa5F
	Vu+wdeVkaIEtcy+Sezvni4KGitxwYJsXk/M5EFAFIzF9RQLt8WMpKYx0T+IpN1oXaiRBA==
X-Received: by 2002:a05:622a:4e:b0:51c:7a8b:c401 with SMTP id
 d75a77b69052e-51caa49039fmr10222971cf.26.1783698205823; Fri, 10 Jul 2026
 08:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708020007.55728-1-atomlin@atomlin.com>
In-Reply-To: <20260708020007.55728-1-atomlin@atomlin.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 10 Jul 2026 08:42:49 -0700
X-Gm-Features: AUfX_mymkLg6O86WvMfSVNUd1VOB0p_rGM5VJHexLUldDKSDY_UVK2hUt0TDUHM
Message-ID: <CABCJKufGH621Vh6JBxmk5XVrFETSvX2tJP1bNiBRg0T-=n+GRw@mail.gmail.com>
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mhiramat@kernel.org, 
	neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, 
	steve@abita.co, mproche@mail.com, nick.lane@mail.com, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Tue, Jul 7, 2026 at 7:00=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> +static const char *initcall_get_modname(initcall_t fn)
> +{
> +       struct initcall_modname *p;
> +       unsigned long addr =3D (unsigned long)dereference_function_descri=
ptor(fn);
> +
> +       if (system_state >=3D SYSTEM_FREEING_INITMEM)
> +               return NULL;
> +
> +       if (!is_kernel_text(addr) &&
> +           !is_kernel_inittext(addr))
> +               return NULL;
> +
> +       for (p =3D __start_initcall_modnames; p < __stop_initcall_modname=
s; p++) {
> +               if (dereference_function_descriptor(p->initcall_fn) =3D=
=3D
> +                   dereference_function_descriptor(fn))
> +                       return p->modname;
> +       }
> +       return NULL;
> +}
> +
>  int __init_or_module do_one_initcall(initcall_t fn)
>  {
>         int count =3D preempt_count();
>         char msgbuf[64];
> +       const char *modname;
>         int ret;
>
> +       modname =3D initcall_get_modname(fn);

If I'm reading this correctly, this ends up scanning the
initcall_modnames list for every initcall. Have you measured whether
this has any boot time impact? Can we at least skip this scan if no
module denylist is provided?

Sami
