Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0B2FC52
	for <linux-modules@vger.kernel.org>; Thu, 24 Oct 2024 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741710; cv=none; b=NdQr2RYnpL2eJLK1ZPrHt6YotmZmG+f+b3bZMr3c5ERQ1ixQstmSWG1mGXdXo28NqfGc1X3RTJPojZCRRPN9UUyFhtfBvcMZbE7VAlGH2agdjnWX09oOA3tXOJstSVRRfhllY98CtqOuRyzGfUH5QjATfprOYTrF4ssTuKXcNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741710; c=relaxed/simple;
	bh=1CvqezbjtLAS+6KXjxvmiUpLjGeozuPDiudCSgW6fIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jblx7G6BcCSAXGsDxYPzVE0McedLq9/hkRwDRt0kPqZmlDxAQwSh+Oy2rbnqEkH3uml/fRJND+sngv3kQqPuNG+Jo1enJbouS0XWb4rFCBTR+dEIGEdSR/CRXq2RG1VQCLzkmNlDCjs/0KMEAXnRvSlPl6012fwzVhJxuv/60FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Xr5eGCm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Xr5eGCm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43153c6f70aso36515e9.1
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729741706; x=1730346506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CvqezbjtLAS+6KXjxvmiUpLjGeozuPDiudCSgW6fIk=;
        b=1Xr5eGCmOYHRXRxDk+cuNGkCcX3YacKZnS58HCSUqzfHfVlb0NX8hSp3xneUh2TS1P
         sdnvzrgtDCXGvtMnU/OkLKd+o1E0ZprULlj29zdqwNrvR3Hws3NaFnb97wuO6td6dWoN
         jO7jnp83tkAe5d/uEm0oQ9jUVjYoFvfXpaTA94SIZ+WydAiyZ8IMxJP1Gyt3C2ivORWq
         d1JRniOV7aE/p1eBP+9hT1cnvQl7/b9nWX53L7492B76LmUTWapXDASYU+3WBj5AyCFh
         iWkfR5Zi7rfXRL6eX2OvdooJRlSkOOV8LEjMntTHAccXO6Op3YUzPaCtxKJWd0LZVj9M
         /rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729741706; x=1730346506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CvqezbjtLAS+6KXjxvmiUpLjGeozuPDiudCSgW6fIk=;
        b=xFtkMBVNDvEb5CYzxPA8Y43Y87nq/D8RY4hzE5JZjNCtLaUQ9/kv1rKjTMtQMIhDj/
         4yjvyUODQfAdsf228JyN3gHeB9UQxgBYoy0OZgq6Ibkg213yWQ3f52me18w7uQWEWANE
         LXYk8aDJBxV9wM3dl1ga0CBiTbvxKN61PS0wgYAG9hnV10v2fhR8YLvqFD7rOeayt0RU
         aF8xVW0QPKuDLoZtFRWWfJCWJLJylrhiyzADfuuH6mfNry0fMKIsEcBRVO1KRdzWuOpz
         Y3Uqv3s2CvmnZSLH8V4NQPqCEU2HaOvNOK0h+CFQLntMlXkWaynyhfwWh25MdPw8E4kM
         kFvA==
X-Forwarded-Encrypted: i=1; AJvYcCVm52UrP+dztOA+ylGPR9wA3905O8RELsZfWz8mRG/H6TVrD7CPn3PmOrH6uez5qp8CuL4HJ5YevfSZ7Mcc@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGnhe1jzpOJh7IXgCl+AvVlIq0kqgQSlnqhEYnZdVP5MdLCQh
	EstgJYg1o1DYDb3JYmvPnv3GXNz/ptnI9Z10cQrcJrCSTDUOB7BLeW5vsI6DCkwfThRUfClClUM
	nWjNXXoFHblrOW8618oqIDWFnjY/nfLFBACr0
X-Google-Smtp-Source: AGHT+IF9JWZBmC4S8twm4VJqy1d9rMJ/zqWLyl8L26tju15cSckHb6GXisfjunNbteEdpKPUf9rmK1A3QeJ13eKcWsU=
X-Received: by 2002:a05:600c:1e24:b0:431:3baa:2508 with SMTP id
 5b1f17b1804b1-4318afc6f77mr1647455e9.3.1729741706337; Wed, 23 Oct 2024
 20:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-7-surenb@google.com>
 <CA+CK2bBzZDdVN66qK4UQ4jpDuAABu89S3mVNbJipaJjL3bcg4w@mail.gmail.com>
In-Reply-To: <CA+CK2bBzZDdVN66qK4UQ4jpDuAABu89S3mVNbJipaJjL3bcg4w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Oct 2024 20:48:11 -0700
Message-ID: <CAJuCfpHFLeYb2Za42=Yp-SxWK-cO-A3N-cOiEY9VV3XUp9kEYA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] alloc_tag: support for page allocation tag compression
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Implement support for storing page allocation tag references directly
> > in the page flags instead of page extensions. sysctl.vm.mem_profiling
> > boot parameter it extended to provide a way for a user to request this
> > mode. Enabling compression eliminates memory overhead caused by page_ex=
t
> > and results in better performance for page allocations. However this
> > mode will not work if the number of available page flag bits is
> > insufficient to address all kernel allocations. Such condition can
> > happen during boot or when loading a module. If this condition is
> > detected, memory allocation profiling gets disabled with an appropriate
> > warning. By default compression mode is disabled.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Thank you very much Suren for doing this work. This is a very
> significant improvement for the fleet users.
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you for the reviews and I'm glad it's useful for others as well!
