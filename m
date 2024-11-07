Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84421766D
	for <linux-modules@vger.kernel.org>; Thu,  7 Nov 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008420; cv=none; b=stPFM6AGYm80fZHuLKaLkvyT8cIxABBQlw2sFncmsqOMhj1VmFtTcOxfNGbi6M0YDanolDxV7Zyo60CqL0vjdemzcoPXgvgEbZYmsAqKPDAUd5arGHl4Fh5MFo7XIsN0+m8NfpB6EJE8hxzGHZIlGeseUtnDjcP1US4PKf/UOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008420; c=relaxed/simple;
	bh=Hqpenv6p1LWFDwIjrHP2BsQXKPVjR2b5HZRJ4ZqChTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYMU3aue78hwRol1Gzjbrg9eCn1IUEERBSGUiOpZV8G0KW5FajATMkr4MZyzs5eD8SSbFGc4JdmLOpGxsrp0H5R0iJ4o2hjRJtAOjQYYRCU8uTytxhkvM1QCdHKQXQuz8umXtm6ZXlUaf0iFOAmjRMXr8eAPUsLlK29ZJe+zZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhgwGXl3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhgwGXl3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so3759a12.0
        for <linux-modules@vger.kernel.org>; Thu, 07 Nov 2024 11:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731008417; x=1731613217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd/75cbpPjgH2M9LbK7DZEh2TDCTCcgqhG32wv/Y+KM=;
        b=zhgwGXl3wArw+w/R+l2xwrB7BtISB3OVqwvwQb25nE3DEQQIzxXLJAeaXnBIey8KEm
         QGhhbyxjo7IFQqdJsmCPANVISzFCfdy/I4FKQq5PF8Hp5zl7BtPb7CC/vekWhkIMj2zg
         D/bFPg/XZzFy+MXHR+ERBnN4gzFH4VWYfMEG7Otcl4p67K08Mm9tusAY+PPnDthmNoRA
         P9kyYFgFkzTO2y8yQa6Xy7ikMrKqZvAbvVftR6SDSyCcqP8Fmo1R1ehIlNnMNDy+EODS
         qzuHEwueFO+yBz6cxzUoDlpWPxo79ZjCFP27QRsyDckDofFAGrQeeIlKwD9VkPvXDCKS
         Cluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731008417; x=1731613217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd/75cbpPjgH2M9LbK7DZEh2TDCTCcgqhG32wv/Y+KM=;
        b=dBQ8z3zJvv3Lbt316aBV5uCA/ImxcJlVRbOjCCiX3kPN0LwP+nJd61JfW4fQobxOR2
         au02EGOs9bTh/XiMhlD8aZ/VXZ0/ATEKWbIuxGJHC6N5pxATFeDumKBcgXYW6nGfgL48
         0B/WVPGhBdUpMN6NLYsNqK0W2coAtjqOqvx2BR8hTEW8oLmOmTgQYYMkOoDepWGgBBbV
         OEK11lS3C6DAsWGCP2f2H0SIS1kRJqEhlyMDmz3OErIpoq1waFdeiVW1qZM/uXw+s4ik
         CB4SpzQaXWoB5SCSe1ethquKoWcxBtWLr7lRPJ5ul4isFOAZ3WkCqQC2G5jE9z0qmpl8
         Kkyg==
X-Forwarded-Encrypted: i=1; AJvYcCXYCtv1whUa+DIZ3Q0pofGa9FHgebsL7TRxbhC6XQItIeFtj9ZEu+EdcjlcA3eG55um/2GN+amet7BytunR@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7mkkxLr12k67O14zQSaR1o1kabmykJ8qTuRI+RnXJtKgtLVK
	h/1UWjSlEmzzOk7At9FsoUjfgmWCnOWxhKi11XKz+gnZwGecT2U81LBa7aQavwJo/oFHf4DqpAY
	JvEDsE4nZ3BnogpBPovDGmxXxIJ5R+5782LNv
X-Gm-Gg: ASbGncsz6XhJjWBOUFCB4UVrmj24zsjnbiBZO3BGDkrFKYIk9kv7cnGWQ783mHNYxZk
	bWrJSAn1fA+2YJzoGpmfjctCtoYwuoxV2ul4qjDdT9zBMazDrRSkLC7XtXXi+7w==
X-Google-Smtp-Source: AGHT+IEBiwFNQfuoAxFiltxJ2hrjOfio8RnmCYl6hN2gWLInsahzd3pu0ISjskuePHQ29yF2SOFAso1eK087KsDFWnI=
X-Received: by 2002:aa7:c846:0:b0:5ce:b7c5:4b3c with SMTP id
 4fb4d7f45d1cf-5cefbcb8d85mr748450a12.5.1731008416865; Thu, 07 Nov 2024
 11:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-1-93acdef62ce8@google.com>
 <874j4tcbhf.fsf@mpe.ellerman.id.au> <ZyMJaFcF4dTTzNgK@bombadil.infradead.org>
 <CAGSQo02H_RwtLpdt4E_LWKjzGvryY_7s20e4QhhA5B7N0LPxVA@mail.gmail.com> <ZyM2cHGaIT9vFOGq@bombadil.infradead.org>
In-Reply-To: <ZyM2cHGaIT9vFOGq@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 7 Nov 2024 11:40:05 -0800
Message-ID: <CAGSQo00=H8iUAP9FwSxgT3kdBmBrzsdWqA0kh5f_5FsBLxyBUQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] modules: Support extended MODVERSIONS info
To: Luis Chamberlain <mcgrof@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Lucas DeMarchi to the thread after voicing an interest in the
modpost patch.

On Thu, Oct 31, 2024 at 12:49=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Wed, Oct 30, 2024 at 10:06:12PM -0700, Matthew Maurer wrote:
> > On Wed, Oct 30, 2024 at 9:37=E2=80=AFPM Luis Chamberlain <mcgrof@kernel=
.org> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 12:22:36PM +1100, Michael Ellerman wrote:
> > > > Matthew Maurer <mmaurer@google.com> writes:
> > > > > Adds a new format for MODVERSIONS which stores each field in a se=
parate
> > > > > ELF section. This initially adds support for variable length name=
s, but
> > > > > could later be used to add additional fields to MODVERSIONS in a
> > > > > backwards compatible way if needed. Any new fields will be ignore=
d by
> > > > > old user tooling, unlike the current format where user tooling ca=
nnot
> > > > > tolerate adjustments to the format (for example making the name f=
ield
> > > > > longer).
> > > > >
> > > > > Since PPC munges its version records to strip leading dots, we re=
produce
> > > > > the munging for the new format. Other architectures do not appear=
 to
> > > > > have architecture-specific usage of this information.
> > > > >
> > > > > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> > > > > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > > > > ---
> > > > >  arch/powerpc/kernel/module_64.c | 24 ++++++++++-
> > > >
> > > > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> > >
> > > Michael, Matthew, why make everyone deal with this instead of just
> > > making this an arch thing and ppc would be the only one doing it?
> > >
> > >   Luis
> > >
> >
> > I'm not sure I understand - the PPC changes are in an arch-specific
> > directory, and triggered through the arch-implemented callback
> > mod_frob_arch_sections. What would you like done to make it more of an
> > arch-thing?
>
> Sorry, yes, I see that now, that's what I get for late night patch
> review. Nevermidn, this all looks good to me now.
>
>   Luis
