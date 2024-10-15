Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720C154423
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956941; cv=none; b=Gne0zDDiSASOfBXOg8Ketq5tfnOe5TSZiZtdg4P4NwXJPmkLVL/K+Dt0vLmwzf7t6qROcA+kpUl08rKWXxSaDlpH1mo4asFRJE1iv8YGpTYyZIvKcmaTMzyLVfZN9Y1IqRiU1W8F5b9zDy4/tlq8BHUSVUrcORPug1HGt6C2DwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956941; c=relaxed/simple;
	bh=fiC+XBWxJTSHPbk3YDhimVLBmGOkquiWZQsNCDrm3uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0t0rhxuAEPjcnfufHTtqxXulpaGqZZdDkZoKDjk3KJftoYnIHbyn+6SoC7T5Hwv9IFaMwYq/uT+RvJR+0agxTV8r//Fu/7Q2WiYFviuP3s4+9Nyt6r/ZOVIkXRtnL+KL/Kq1kXq56Er6yQuXEaga1uSLMZL74TpxGfHK/xCatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAxMRgSq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAxMRgSq"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so942305ab.1
        for <linux-modules@vger.kernel.org>; Mon, 14 Oct 2024 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728956938; x=1729561738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTpr4H8C4FWrqjFNlXZjN+OALNaMX37MopaCmWm2Q8M=;
        b=IAxMRgSqOJpqOxMZeGkq45lPAlVP8D/uSav9ABE44MUPQMOIBVpM4r8zOJnQ2bfox9
         y2Z1w11vx76Kjz3LM4fqoWaJt7XCLCWjyM5Dw3hTFZa5XwJGJ+4FauB9biWvKHBiKAc0
         ezasCB8qB1aR4Ws3/JPS6hzRhgSfiZBCdCENU/f+ILRnsMRvFFKYJaJqnd09cPEPKVwW
         YhhDpNkNDAoygnyO4+1clyiVDBsaPLC/HLExon2QtdtoaApe7tSjmxHPSZW2Wzxl1+yi
         9Kg2v7RdhcjjU7uZuKPrFVHzYrLFBj5sSzxl0immuAAFmiaCw7O83Y4mhdDgqPoaDKKJ
         yomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956938; x=1729561738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTpr4H8C4FWrqjFNlXZjN+OALNaMX37MopaCmWm2Q8M=;
        b=UXFqFa6Xuh1eFs1+UQhoBUrVuTF+UlqCWuU+YX9bQa8vvd0U+fJEQs6PRZ+SOma8oQ
         qPzxcm9WUainsKwofjOxFLW7A2SolRqzVSDrHfVvUt2g7JXdlCP1vgXtjriJ1kC96TjA
         fssClfjtoTsrYTAztQJ9T2kNqVej9mUqWUX4IfGoBF0mY5HNUJ32bxjAQ8TZDw0S8kTW
         Yb4StSTcSiGiv6r5BAdV4RUu5b42JytD4Si0oA42i5aYOTlDWLjj5ZtiMqLAV7W+CYb+
         m60vPccbe+ZxwClE2lOABxbvB4arAgQg7O7pdc4gQS1R58HX5QyoUTZ0US1Fi8evqPoi
         Y+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeargVVoqpSiaiqrPTiKyY5ztZC7erojIu/oRuuTB3RuCXO/hSEu4kdj0JEjNryA+AY6XSDd2n3J8c3Iyr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OdKX2uPFaRkQaY3s6Zo2O2nZ/6nXmFLN4Tfdq8lhA/jqiD2J
	XnzI4qRruG7sXn/zq5ZdmbiSgAHj6NekVKdSC8GESrCF9ohK6jV7RFPPpm6ujmhzXEVfXUxze7l
	p4P8Ig+y/NSc8s3FyVKsmxdy6z72XCjIJy7kJ
X-Google-Smtp-Source: AGHT+IGesUbiPOAGaxIbzzDgO9fqyDFQzVpz+70lg/ZZegnkGH6H5WSOBtADDa6r+PO3K17MJxP/ANuwhYpFXw18SQc=
X-Received: by 2002:a05:6e02:1446:b0:39e:68d8:2891 with SMTP id
 e9e14a558f8ab-3a3bd2cb5e5mr13845395ab.6.1728956938353; Mon, 14 Oct 2024
 18:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014163231.9ef058c82de8a6073b3edfdc@linux-foundation.org>
In-Reply-To: <20241014163231.9ef058c82de8a6073b3edfdc@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 18:48:45 -0700
Message-ID: <CAJuCfpHo=gu-JJ-N_nU_3hX4HEsfsQ6=ff19vU=NCrp1y3abiw@mail.gmail.com>
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

On Mon, Oct 14, 2024 at 4:32=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 14 Oct 2024 13:36:41 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Patch #2 copies module tags into virtually contiguous memory which
> > serves two purposes:
> > - Lets us deal with the situation when module is unloaded while there
> > are still live allocations from that module. Since we are using a copy
> > version of the tags we can safely unload the module. Space and gaps in
> > this contiguous memory are managed using a maple tree.
>
> Does this make "lib: alloc_tag_module_unload must wait for pending
> kfree_rcu calls" unneeded?

With this change we can unload a module even when tags from that
module are still in use. However "lib: alloc_tag_module_unload must
wait for pending kfree_rcu calls" would still be useful because it
will allow us to release the memory occupied by module's tags and let
other modules use that memory.

>  If so, that patch was cc:stable (justifyably), so what to do about that?

Now that I posted this patchset I'll work on backporting "lib:
alloc_tag_module_unload must wait for pending kfree_rcu calls" and its
prerequisites to 6.10 and 6.11. I'll try to get backports out
tomorrow.
I don't think we need to backport this patchset to pre-6.12 kernels
since this is an improvement and not a bug fix. But if it's needed I
can backport it as well.
Thanks,
Suren.
