Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64111199E98
	for <linux-modules@vger.kernel.org>; Tue, 27 Aug 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767245; cv=none; b=A59fQM9TO0lTpBfW3iLlMUx7iN86HDRLrNu8y30eVl60fGkgatiMNMDlkuzEK6Lim3jcYfmZTUDUSkTiYLh3cGvnL9pYcY/oUaWkdZtQy8XnaH5Ea3NNkHBFVEEUjZDal2EyCJW2UY7xcfFSUGQlGyNOLid8gPf22gGXblgU7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767245; c=relaxed/simple;
	bh=/q4kKzosiUOSKJRCBjUonXD/HaaFvIdGv1Ci64z1xc4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK4cU3AMLeiwD1SgBJx26DtrWMWDEGz6lrlIbbNsptpmRhPf12UMwB7f2QG/DTRRz4keZ092nTcwOtzB5sA5xTJ759KZ9b2V5BA7A4zapp1as9v74pBzmMII4aKe7Yju7lpP7r9pVbIgVjtYhgFiVtCSSzGsxnDhNhcJo1vYwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=SNTNX1Id; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="SNTNX1Id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1724767234; x=1725026434;
	bh=/q4kKzosiUOSKJRCBjUonXD/HaaFvIdGv1Ci64z1xc4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SNTNX1IdTOZorJhgy/gJCMOoFxvqyRWd9H9ScRgavoaCqDJ64b913/p2I5S9Ziy1H
	 VfzGaGPyO5AM9d+I7Az9Luu6sAlj7VXbDmfZm6c0tXHFVEOeHbotI8ILg74/MWR1XK
	 eo9Cpoqaqa8zRTsqBJSlXfgItFGyLQ6bsl+khIFr1RZIY7/FpzcPBzNWuABhbkLWRT
	 hDTPMGpXVfFqcHRyoSt420txuyLkTikpUb0wapx3hsAGdnhg77f8JMjgCBiupmMnlq
	 OWBVpyxFqdHXvjoIIlZuZ5LjGbWT7WHqXl+2GKr4z3sLkPsAnpjTno0I2UpsgxmZSY
	 YHRdJmx88DPkw==
Date: Tue, 27 Aug 2024 14:00:29 +0000
To: Trevor Gross <tmgross@umich.edu>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add `module_params` macro
Message-ID: <875xrmxdzg.fsf@metaspace.dk>
In-Reply-To: <CALNs47sF1o4x-=wPdy6c520-sCX_+sA=158MMP9c0SByKvwXfw@mail.gmail.com>
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sF1o4x-=wPdy6c520-sCX_+sA=158MMP9c0SByKvwXfw@mail.gmail.com>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: e95aa94bc582d4f3706489047c00e71145d4face
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Trevor Gross" <tmgross@umich.edu> writes:

> On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>>
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>
>> This patch includes changes required for Rust kernel modules to utilize
>> module parameters. This code implements read only support for integer
>> types without `sysfs` support.
>
> Also, I think the subject line needs an update ("rust: add
> `module_params` macro")

Well, it is still what it does. Plus few support types. You think it is
not descriptive enough?

BR Andreas


