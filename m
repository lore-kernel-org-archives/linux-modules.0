Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE3170A3E
	for <linux-modules@vger.kernel.org>; Wed, 16 Oct 2024 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056811; cv=none; b=azAoUBFj0cUAMuCEAtB+Gm+Bh5UVCzAWfS3FY4AttS5kL0fGmlXQI1wmptBZawcEsvkOQb+TL6+slRXLolpfNyN1a2bBq0zk6osHxRwOpc5UQhc62LDPikY0djWiFMaWKcj/kQzl0S2ntKMJmHuMgdrpZztnN8dTYV1Qh5c22GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056811; c=relaxed/simple;
	bh=a8AHrour6y3gtSVQgfuTGwKhI4oiODFOIV0RsJ1H81I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n177vJOXHD51gMObkn8V8/PmkrTGSCVYBw0nC+7yVDTFmRbH+vur/44fO7LGOrMEvsTlICvR3xDAejeDg40jFVbxLiHEHr7dSWEiQJcCRMOr99RpffGvlPeg0iPWrVew0unC89pwoL5Zgb889zlT4poKdxfFSUmWWzY7BMO+C28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDGBBC4h; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDGBBC4h"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so75015ab.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729056808; x=1729661608; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE3n7neBCFO0QX3SRz3T65QnhWq2c+d+oC2i4MBN32E=;
        b=pDGBBC4hEwg1iPsMzi9bQ3+KMqgaINZMNpjYEUFDC3VR82QnxUUZoMvO/8F6zNk1LD
         e3dcK48akf0KDNzBL4LUsa9kV6eeyWXDUqIeXZQIccgYaqOwLFqg9Ys7jmC6QoSis3Mf
         d6wbPyWC5OsB5X5D31sx0BZLd0Rc/XMFnY5IjE2QP3c+VcXKXe9rSBK05vy2Qk88BeNd
         HfzR0FLKzr7pnXFhjLgqTlIA4orch8vOyfmcOvai8k83rVQoIuiFpjqqIoF/UNUoR3OF
         IGZEzBnbg1v959oHOOEdXrADN+pb23RtW69+KcNQzrlIPA59tLW9gliSRzLTDXdLiX1R
         k+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729056808; x=1729661608;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE3n7neBCFO0QX3SRz3T65QnhWq2c+d+oC2i4MBN32E=;
        b=ZDuLv4KL37K0L0v6PdjT3hNwL2+bGE1YKHId+8pGkThG68MmpG9u/8r40zSXYbLEwH
         s4tfZnaEKevEwFycWr2Oo1BDx+XseVsKvmwxkSFwHBbsgO4CREgfjgHHuvClrCag9f0E
         hPoD2aqV4RCzT3/F8p8bhxSMosjpdypBWrlsZ3FWIRRdRQ/aj9BM7IeBQpzQu8afBrH5
         aAAu0oIqh5XvdZliH+BjmORN6Xjxr7SG/oGRl3fJrehqUQPzSOYqiTYxk1y59dhh6fS/
         sXPiBEpvdUbWk1xY59QxtxSWbhRRxmHgQKdRChzNH9BMjKjLXK7Ok+8tJuSwAC5q0xCH
         +d3w==
X-Forwarded-Encrypted: i=1; AJvYcCWoplfoeZM78XIj2LYCmkxehkRwsPL6twsqQ4K3rtit+gBBGdQ25nbGNmlvHLiwIVGQjw9Q6E/OLOjh1TbT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8jH4LZOWE0ajkkKgsRDAOhGyhmHeFoYyX3Dz1DXlV1Hvww8z
	Alidy5EQRHWMP43DqPsVlsy/BvNw92gIe+LLGaxGx2lRrChUjuJoPxwPzMm2p9xDbC8Z5KhgsAT
	twpLUkpWvspn2yA24hM+RcLYvh+ZgjUCPDfFl
X-Google-Smtp-Source: AGHT+IHVny0OObU929AfXGoqJehfn3ed3sWMkp/JKdrStFJ+P9YrlgLxFcEP8zDxPHDtQik/xhI9gZNftcG09QqbV38=
X-Received: by 2002:a92:cd81:0:b0:3a0:a233:caf8 with SMTP id
 e9e14a558f8ab-3a3ddecf747mr2346255ab.26.1729056808205; Tue, 15 Oct 2024
 22:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-2-surenb@google.com>
 <o3jak2i7ohhxi53xlthv7yy3oop62qpfscel36szn4sctg67ip@ctrntnrcauav>
In-Reply-To: <o3jak2i7ohhxi53xlthv7yy3oop62qpfscel36szn4sctg67ip@ctrntnrcauav>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 22:33:15 -0700
Message-ID: <CAJuCfpF2Xe4XcvruJe7evZpbYY71W7SVjbXQ_+XgzJvcLtVuuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] maple_tree: add mas_for_each_rev() helper
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:48=E2=80=AFPM 'Liam R. Howlett' via kernel-team
<kernel-team@android.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [241014 16:36]:
> > Add mas_for_each_rev() function to iterate maple tree nodes in reverse
> > order.
> >
> > Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I am now sure I added a R-B in a reply to this :)

Sorry, I missed it. Will add in the next version. Thanks!

>
> > ---
> >  include/linux/maple_tree.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > index c2c11004085e..e7e2caa1a95a 100644
> > --- a/include/linux/maple_tree.h
> > +++ b/include/linux/maple_tree.h
> > @@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_st=
ate *mas)
> >  #define mas_for_each(__mas, __entry, __max) \
> >       while (((__entry) =3D mas_find((__mas), (__max))) !=3D NULL)
> >
> > +/**
> > + * mas_for_each_rev() - Iterate over a range of the maple tree in reve=
rse order.
> > + * @__mas: Maple Tree operation state (maple_state)
> > + * @__entry: Entry retrieved from the tree
> > + * @__min: minimum index to retrieve from the tree
> > + *
> > + * When returned, mas->index and mas->last will hold the entire range =
for the
> > + * entry.
> > + *
> > + * Note: may return the zero entry.
> > + */
> > +#define mas_for_each_rev(__mas, __entry, __min) \
> > +     while (((__entry) =3D mas_find_rev((__mas), (__min))) !=3D NULL)
> > +
> >  #ifdef CONFIG_DEBUG_MAPLE_TREE
> >  enum mt_dump_format {
> >       mt_dump_dec,
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
