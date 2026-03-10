Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EC28504D
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150334; cv=pass; b=kOqjtLmqCkHz8H0ANlM8UdomH40YnhF2j1Gf2hmJlqLX/42YrOdFZMUVMjUlODY7h5xQZyxYiApiEoaUyA4izECymnvRrCULAtcTzVrAmSGcgeUqMmdyD7C5dOH3SZ5FjgAKDRYBEmT+xIi0FbOrRk7gEqnP3xFFh7X5QisYkMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150334; c=relaxed/simple;
	bh=T965qupBmszB0/8+JNMtpKqug7k3VcL+NKrHXxWw1ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb+1+7Je6Pk/6dB9i6qzIoc5noymhlKZXMVKE+5LQ/OuzdFgTh+mvmvhrwo7u95072+5LWJbF+8hEUlSBXUELBSQTQLbEgOmkmaW4sUL42OHJWec2UejVPs8k+0CXkCWs3LHRYnzlJg+dlbKBRTnJn8bCX94azMFss3o153yjeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYlPURKr; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYlPURKr"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986fb839f5so113420247b3.0
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 06:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150333; cv=none;
        d=google.com; s=arc-20240605;
        b=EZpbqQkJ4WtU5+ZnsS6vZVeeAg4E9R2UxKURjoZyQhfNgaqE8hAF1YHKgfQeEE7JP0
         hMnZL8g2i2iR9X3eYIZ0LJOcY02CDAOCtjN85XWZI6nrj0+a8Y+MDgL9xJysCx1cjV7o
         XBsddzyrRQ1UqC8yvubdbYNXy4oj1YVLKxLPGAtoztg8J0QgDApP5ubkTW+eO0zawGd+
         iGl2sESpepo4TqNGHTlmdsFNkqkZnp2Hfo/t/cAJ1wClyIg8dZ/f0v6WMt1KvTxO6u5t
         G2hrwp/jLAkgOQDjRGD7Difn3JkyhtNZs3bugllxVpiKvSSRTgYNF+6qk19Ms3qidebT
         jTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5+s7/YgHRdjjp4/BxYKOkWCbBhpFuC/6XLDd3r09Es=;
        fh=sh3YlO6Z2XiDvkOjkvME9lW3KhQbAiXgjuxoOdKyzjA=;
        b=k4NfzHQjCVri/eRetRLChHFubpgohd9UJPwEDLSgWjgJEqSCyJTlMz7j/Z027wGobF
         69qTI1rrPh+lRzsp9PUtzLLH40StI6/at0rkI2BPR/UUnKYqtWF5ba+5t7RAW7hK1J01
         8Byiv2qgXk8y2ldNgiu7e4/88nxoNiaK7E7dqIxVDXk7Cy9pMfIa52KsLAEpoQVoJh0c
         vNrgzbXY6NqtC1/FoR3HD6l0IuzL3bFy9YmLcyiRBW3iTsDjkWmDVH41zeC9ZGjauXCe
         6ajQYPox2nzihojAMDgvJqOIbBla8ET3i1GbeQ1MOMDnzeV2EdaFCcDO6HrBP7nKTZ9v
         kDXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773150333; x=1773755133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5+s7/YgHRdjjp4/BxYKOkWCbBhpFuC/6XLDd3r09Es=;
        b=eYlPURKruSdS/2NLs8jYyosARJ3d/EkLzsH4qX9t31yB5SmbtYz8BCLnaQuwPCuLxI
         6a+sYcvvCobG/FImrZ3x50qPvECl8KM4p5MsgnHaLmCNrMwXAtJjozDZ3OaGjo+fMUju
         4qEWyBJpIb8xrXFb+psK0pzuWT4X6LVd9j95UEhE+T79jPyv+MVd0csveXr86ScU+9K4
         tZhvvF9GCswn3pRw8aJ+WFqTaUyPkFav8FXAAtshj25upnwIvPH8qOHlvO7SGXIRX9yd
         LFD1n+kkZMTXNwp6e2vXzumcTx3kF/g9cOVvcpTIRkk1B7+5V/bYh60rmDST5kajI8PV
         CYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150333; x=1773755133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h5+s7/YgHRdjjp4/BxYKOkWCbBhpFuC/6XLDd3r09Es=;
        b=datSEKsdyCoXGiXAUNAbLXOYmSG4tkVlwVj298aqxAr29aIObvnEwYPxgkGoaL8Nc6
         NilqFgctaAUUiwN2c4Tyy6xqFJtMaBN9Y3ZSeg5tsLrafRRGmn+fSUW3BikrDCsr+e6W
         T/rCyX4DDQ25yr1p+wZooUZwahTX/xwPtRiFYsLERtOg6yGKDe25226lSJI0Er+TQjeZ
         jWfq7mKnRkzLChr2HoZHCqjrooQyFcEpD6Uv0m9a8+4WCmzxzRpZE/MUpcfkZ2sdwT1T
         ETTSJky6TctS/eOLtu+JyAz5DX80olUqWvitMOP7gx3KbvWK+4JSDCxICFJfUFCZ7Oox
         woTA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSwGieQGaDgYkaH5ZtQNFIHpcEF6pdfizb8u/iUSHNWUjyxHwTK8+EPaocwGNVvD+kjuXwg0YyHTAXd71@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVF05ALQd0dyQKC1Mnm72jrYKPNpWCYI5cyklZ6KxQOO6cJaX
	MI66WdQ+GhnyAJ9LxhlDFpodEBSCSjg0bOmgNLPLHYGImwlU7p5EW50OujogdkBXl17zYC5sT9t
	knZFujHhrYco1chUEC2ND4hnVpVqYN9Y=
X-Gm-Gg: ATEYQzyy640aWxACz21ro2gOVcTHhBrmP/bTEi0aN2hKNWQFnVQXhZEAY5jzsQlZlJM
	M3h3wW5t4iksTB5IzTYoLkWKe9tu0+3k3uwsWQ/uh/VcTYyN4cPqrHi77Fj/cfTSqLq1ciBLldT
	dq+aVBDDotyCFr4bXJ+np9fju8sKHib1WLHCXh8+YUbFx2go8dnptelRpdk5U78fCcym6g9zxDE
	lDes6ef96+JJ8DsZxHfB8DCJO2TpMPs/VQDM9LnonWmhaLzvFdH/Ek/ULkbd72qvvyygkFKMUPy
	L3SRd/o+
X-Received: by 2002:a05:690c:87:b0:794:cd8e:3616 with SMTP id
 00721157ae682-798dd69f031mr145126027b3.21.1773150332712; Tue, 10 Mar 2026
 06:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa-6wILF90Y4ndnd@infradead.org> <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org> <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org> <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
 <abAa03DO9aLxWcwX@infradead.org> <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
 <abAdr6zqeqSNMJ8X@infradead.org> <CALOAHbCmxa0ptYTcq1EjRKMrzvFHCyyrv8CeEDYOhuuo7-QbOw@mail.gmail.com>
 <abAf5ZtiQGFoOQvT@infradead.org>
In-Reply-To: <abAf5ZtiQGFoOQvT@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 10 Mar 2026 21:44:56 +0800
X-Gm-Features: AaiRm50zcZTJC85OaW7YAdGYQELUlBU7tF4UL_S3LNKlV6cOtWqacCqcv2ww0d4
Message-ID: <CALOAHbCg=nmwtoaMJj1KpeGqAXEuuAdnW+RCbe5KXxKKYGozzA@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Christoph Hellwig <hch@infradead.org>
Cc: atomlin@atomlin.com, da.gomez@kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:43=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 10, 2026 at 09:35:23PM +0800, Yafang Shao wrote:
> > > Why would that matter?  You don't get a wild card to do things otherw=
ise
> > > rejected because you contributed something before.
> >
> > Could you please explain why I am being characterized as a "leecher"?
>
> Because you're adding overhead to the kernel for your out of tree code,
> which only you and not the kernel project itself benefits from.

Why do you believe the kernel project cannot benefit from them, given
that all module maintainers have acknowledged their value?

--=20
Regards
Yafang
