Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5314F117
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009598; cv=none; b=o2Tps7uQXZF2SPfhX+AuGjf6bQFw1lRh/D9VsjhPdxBf+mFYsoGSD6OAtv7f4/AVLgmW0lRlmRPJ0OQCrJxjZLRpxAn5ogZ8gTlL2B6fZgBPwdQGJvou04uzEvixqDBy80Rm83dfdTw7fCML5qqCG9K+woeA5PdNcFyD4bmqqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009598; c=relaxed/simple;
	bh=r/LUYHfo0b2oPsQBnswC2i/HWfTInJ4Wj1YFss1OM0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQLi137xoNts0Gam8n+HF4IjQzUkxgUgWYU8zedoXKVqOvar6t9savSBwHQom/Xaal3mFxjGNODxrDDvrgpPkHypvw8eeal03sbJfzU5gNcSNOyEBhlj/LJyPrwvNzlB5oTiXBb4EGcoNn/deHqpAfQwwdYIkHIEutxK2sHcKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dceeE9jM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dceeE9jM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460395fb1acso793411cf.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729009596; x=1729614396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByNOtnqk52ePIj5atFjVP7CCcQ9LOwoYrSe4G9dfPzk=;
        b=dceeE9jMcx5ICYSFz8cO505jHTInVLzivWeO58vZkYzaQTAqGPDgZt2Wa+/bvDFSdD
         U7KHzgB5Zofr6CT/qM+np5ihKnQc0/YvpyjG9UA4dCyddatP5GO+q1yJsaK/8yXAX4Tp
         gShJUkXlW9RhPfywCLTsPKFSOuE2RTIEsc3HORYutBCvh1bfralHG/bTNd9+omHqUoRy
         SvkdV1Fx6J0TCGhIf/N61l23yvuYwpRP/1iAGZIFX2La/k0cFVx2wxtji+BJkrlxuAaH
         mtwh5c2Pxoa1RZR+gmz18/5yqh5Rvk1ETPlftuVvVxuti6To/lCKR4kmVjOAWezSfRp/
         1Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009596; x=1729614396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByNOtnqk52ePIj5atFjVP7CCcQ9LOwoYrSe4G9dfPzk=;
        b=JFCAj1sYu+KsMc/LbRj6rcCeuA2XMdzOCgxNQFohXccNzjEX+oBUT/u0LPiyArTlIS
         C00We0g8uj5epCaO6iV03t8DiQXGuMsdwlwPXfiFmLqYa/GO+Au2tCr8kW1KsZel9PJd
         Cw/vQLBi+9MDDv9ErASZjJpNjXSxqz+ulj5o1QHIOJTRNXV5KSuEAiqxMDrQCENHSuJ6
         cQ7EFqj68C27ILIvzfNtRNBDdFydqZtPLApWlVcFjZuZeOx7CcwngqVMiqpkNhIwoFmH
         avovVQJyGVDDQg9S27BxRMvEUgriz+1BolX4Fs9IokBfpki+ThzGACvYU+mvUHMJYnCH
         XNjw==
X-Forwarded-Encrypted: i=1; AJvYcCWaO0UWDdTZC5DXa/lZYVRa44vaBUESjmaxwMi6QEBvHeiJUE8wT9+HFrPTm6sE4nX5YvozVhWuDUCEXoXc@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUuYBE2XKVMUi/l5iTL2zQvMwbAYXfaLoOvCzsCngTWSEbiv7
	LgMxz/o6EkQtiQDXVxQhrdCLG6REKBKrq4V4LPoYniGRy/ODhUQ/G9VojSjo3V2ymj/HyVHpv0O
	l845mGNbtt5Al1vkQ7Pzmb2GixRwQJo0vsV6V
X-Google-Smtp-Source: AGHT+IEJf/zEbvfRLlUBkavHUP4hlRMi5TuBiNYWQTdXNa6kRDfahgq4f8DAV0x/WUWXlEXeRgomzUcU5kxGSCng7Vk=
X-Received: by 2002:a05:622a:848e:b0:458:17ac:2913 with SMTP id
 d75a77b69052e-46059c43d71mr9480531cf.11.1729009595317; Tue, 15 Oct 2024
 09:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014163231.9ef058c82de8a6073b3edfdc@linux-foundation.org>
 <CAJuCfpHo=gu-JJ-N_nU_3hX4HEsfsQ6=ff19vU=NCrp1y3abiw@mail.gmail.com>
In-Reply-To: <CAJuCfpHo=gu-JJ-N_nU_3hX4HEsfsQ6=ff19vU=NCrp1y3abiw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 09:26:24 -0700
Message-ID: <CAJuCfpHMRM1GyzCA_=v5V2kUZbprvNJD1aFmpF58vm0w4eWBHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] page allocation tag compression
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:48=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Oct 14, 2024 at 4:32=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Mon, 14 Oct 2024 13:36:41 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Patch #2 copies module tags into virtually contiguous memory which
> > > serves two purposes:
> > > - Lets us deal with the situation when module is unloaded while there
> > > are still live allocations from that module. Since we are using a cop=
y
> > > version of the tags we can safely unload the module. Space and gaps i=
n
> > > this contiguous memory are managed using a maple tree.
> >
> > Does this make "lib: alloc_tag_module_unload must wait for pending
> > kfree_rcu calls" unneeded?
>
> With this change we can unload a module even when tags from that
> module are still in use. However "lib: alloc_tag_module_unload must
> wait for pending kfree_rcu calls" would still be useful because it
> will allow us to release the memory occupied by module's tags and let
> other modules use that memory.
>
> >  If so, that patch was cc:stable (justifyably), so what to do about tha=
t?
>
> Now that I posted this patchset I'll work on backporting "lib:
> alloc_tag_module_unload must wait for pending kfree_rcu calls" and its
> prerequisites to 6.10 and 6.11. I'll try to get backports out
> tomorrow.

I prepared 6.10 and 6.11 backports for
https://lore.kernel.org/all/20241007205236.11847-1-fw@strlen.de but
will wait for it to get merged into Linus' tree before posting them to
stable.
Thanks,
Suren.

> I don't think we need to backport this patchset to pre-6.12 kernels
> since this is an improvement and not a bug fix. But if it's needed I
> can backport it as well.
> Thanks,
> Suren.
