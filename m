Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5A1F6682
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007955; cv=none; b=D41P2wDGv3bwbYdSGxZSqI8NMzPkHou9eCwRyalyIVXvnkMx+JnShyCUkE3svuqjGJNZzuGcQYebRUR5YZTp1ecaeuxBfxbMQYGmTwufCXVteIigq9rjjXEgXSM/XbBO2kk5iWwuqTzDbAZagSwJvQBhbIpdI7VLvvQe64ekS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007955; c=relaxed/simple;
	bh=XE41Ka7vKxZjagEXLHac+Fwc56DYu0ANyHcZAa6jXdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB2X5Owjl6MslV9F8i/MhUESWJkB2nzzzWT+qNCdUsI1tp4swhjkOpbq0OrZnUBx8HrroHE1rA6xqJOpzyskNARvfTHBWS4JfDEdUGoJf1wgwJ76uFUstmm4mEuaG2XBdJSIwoIkTEDeW+/cO9roEqFGxdt2l6PbD1kuqBacjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=InYUrCyF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="InYUrCyF"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460395fb1acso782701cf.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729007953; x=1729612753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE41Ka7vKxZjagEXLHac+Fwc56DYu0ANyHcZAa6jXdw=;
        b=InYUrCyF1rEOsYNSVAHRT+QpeORYlDOg0R9f1bATZsSE/a5ljFOeiaptj2jum+sDAX
         0lRFmdxIS1u8eJQ84mnPKZAKR12ik+LepB87gcmnQzz+O/wQ4aUXtrcDTrJ7BIrva3Qs
         e4V888udjmjBsVm2SW1iyJBPaDueyJ+F/8wUB64Lc5Mj6t1U7IFWzF8Bq9RRUHXIpIMo
         9JWqc3pNV4MP0D5/NVKhIMZQRSejoDe9qMGSdKd6HddesKjtKw39vr2QWr6hGhA6/Ae7
         8614dwy8S66dF7jqMN6oOE5yhSU4E9h4YdZkDNe7Y1i5KTZIpj30uX69gXpbhLkgk/u7
         r2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007953; x=1729612753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE41Ka7vKxZjagEXLHac+Fwc56DYu0ANyHcZAa6jXdw=;
        b=fzl7vmQRuvh7Vd4h3q+N2GylW4oyffiKnlRb1ZkAtuu1AHUp8mqZrl0OMu16PYfmiX
         1yTr5njzX9t1LWs3WtgEbRURfQBDvycOZeR7H2Arjy5h3UL7YOWNyQg8VTQasabxFKvs
         PDue5tK/VBC/P2PSMiAS1NUCy9RZz7pLOEkhHhd6+uuT44THQbzSInaW1VN3di8JUCI+
         CPma47aw6MOFRQ73lQDKw9V42mvRDGD/JnR8UWeCCqRe4KjkTvO7qeL/YsAaBu9j+Jq5
         iLM+25CJ/QGw4AVz+Bt42BKtxwFb7Ue0fxShBdAfiP1AvX4xUV0fmAFfablpZFWskHNn
         ctVA==
X-Forwarded-Encrypted: i=1; AJvYcCXutJU39B2En9ONL3O6mxakae+Q5Bqa827PhZqD3fvehRUKXSLlztLvfSq1foa0BWfyizpZeRP0Gox7Lfom@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8E30KNmryjAEtIgsFS/0NaF43lFT9sb78Ia5Cxr/CjWmVR6gw
	7q7Vf7mDVz3UFs7GbSikT5J2l7his5uH0QMlZZf/TrMzkDDpKVDVRiTeGXc3GNLiEF1Emk+ih/N
	HjTLMR+FSTM/vDpMTbhq4JnepR4qX26HoAP8/
X-Google-Smtp-Source: AGHT+IF6xgKzdwApAz/tp26tbpQrjDXqxixmCCmxzkzM5PRyG4nrJ8/4jSASshjSbXG9ZNd4t2I6D2nt4kc3vxb6XWk=
X-Received: by 2002:a05:622a:4b05:b0:453:56e7:c62b with SMTP id
 d75a77b69052e-46058ec036amr9300601cf.12.1729007952467; Tue, 15 Oct 2024
 08:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com> <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
 <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com> <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
In-Reply-To: <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 08:58:59 -0700
Message-ID: <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Yosry Ahmed <yosryahmed@google.com>, 
	akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.10.24 16:59, Suren Baghdasaryan wrote:
> > On Tue, Oct 15, 2024 at 12:32=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 15.10.24 01:53, John Hubbard wrote:
> >>> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> >>>> On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> >>>>>
> >>>>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> >>>>> references directly in the page flags. This eliminates memory
> >>>>> overhead caused by page_ext and results in better performance
> >>>>> for page allocations.
> >>>>> If the number of available page flag bits is insufficient to
> >>>>> address all kernel allocations, profiling falls back to using
> >>>>> page extensions with an appropriate warning to disable this
> >>>>> config.
> >>>>> If dynamically loaded modules add enough tags that they can't
> >>>>> be addressed anymore with available page flag bits, memory
> >>>>> profiling gets disabled and a warning is issued.
> >>>>
> >>>> Just curious, why do we need a config option? If there are enough bi=
ts
> >>>> in page flags, why not use them automatically or fallback to page_ex=
t
> >>>> otherwise?
> >>>
> >>> Or better yet, *always* fall back to page_ext, thus leaving the
> >>> scarce and valuable page flags available for other features?
> >>>
> >>> Sorry Suren, to keep coming back to this suggestion, I know
> >>> I'm driving you crazy here! But I just keep thinking it through
> >>> and failing to see why this feature deserves to consume so
> >>> many page flags.
> >>
> >> My 2 cents: there is nothing wrong about consuming unused page flags i=
n
> >> a configuration. No need to let them stay unused in a configuration :)
> >>
> >> The real issue starts once another feature wants to make use of some o=
f
> >> them ... in such configuration there would be less available for
> >> allocation tags and the performance of allocations tags might
> >> consequently get worse again.
> >
> > Thanks for the input and indeed this is the case. If this happens, we
> > will get a warning telling us that page flags could not be used and
> > page_ext will be used instead. I think that's the best I can do given
> > that page flag bits is a limited resource.
>
> Right, I think what John is concerned about (and me as well) is that
> once a new feature really needs a page flag, there will be objection
> like "no you can't, we need them for allocation tags otherwise that
> feature will be degraded".

I do understand your concern but IMHO the possibility of degrading a
feature should not be a reason to always operate at degraded capacity
(which is what we have today). If one is really concerned about
possible future regression they can set
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS=3Dn and keep what we have today. That's
why I'm strongly advocating that we do need
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS so that the user has control over how
this scarce resource is used.

>
> So a "The Lord has given, and the Lord has taken away!" mentality might
> be required when consuming that many scarce resources, meaning, as long
> as they are actually unused, use them, but it should not block other
> features that really need them.

I agree and I think that's what I implemented here. If there are
enough page flag bits we use them, otherwise we automatically fall
back to page_ext.

>
> Does that make sense?

Absolutely and thank you all for the feedback.

>
> --
> Cheers,
>
> David / dhildenb
>
