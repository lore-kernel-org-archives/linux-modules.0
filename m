Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3B4594D;
	Wed, 28 Aug 2024 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816608; cv=none; b=RZbjkBBFJHhX8L7WiU+ziddoBQV0vyUcmRE37FNc9NbhJBdy7EBQS0vIV5DO4ff5osRqQfd1YkeFv9Z13d0Ua8nDJ+MBgjYY2xyAIdHlIfi9LJSeqdrF3hasW9+7BhI+11WPBdf7kJsOri0T2MvXvS2H8or1OXzFrmpZXUyL2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816608; c=relaxed/simple;
	bh=6/tylI2FvjNZ0x65xJzqgWbbSYIr7+H9PBrABl03S3s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHckH4Ns/YJct/Eriq6f6flKTBqP9HxZqyiaq6PUS6iycf2k8v0HtT4yfrOQA10tupl0cZYXA7wDytzCeKpZVAeh3YamHm2GV6FbRcRTxFg9NFzOHTZkojoRI5ZvOwX6PAID4II88rnhzB7ug8vyNdS0r8edntxEO9NdFUgXmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=Zk8mHozu; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="Zk8mHozu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1724816597; x=1725075797;
	bh=6/tylI2FvjNZ0x65xJzqgWbbSYIr7+H9PBrABl03S3s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zk8mHozuVT48dUkZlSzOOzk9Z+HxPaXT9QwcJnNO4LNxebAjxL3xoCVTaqNhCqA6A
	 l/5cgj7gEjPfAH5IraGD6l/bkGyb9tzQvvinEmymG/5JC6wx1VMTBXpPqN4Ow6JAsf
	 eWyUKjSZL4ryaUIf6q6rj7XwFZ6jzCR6+9mECUA7tRChYeEgw1d31XzEUq4iUn/O7l
	 OjTRyZa9eLosPU9pSL9wplCb7xGQz/I8AXgshV0AViD7c/izEnRlZBlXPE10KFrnwb
	 IgUowEklqwt1OOfoqeaGW3GvUfiUYCaLZHyNJIjE1GyqzYEtT2thlbt8HiPGMmEaNi
	 cNsi+gWrcvErw==
Date: Wed, 28 Aug 2024 03:43:10 +0000
To: Trevor Gross <tmgross@umich.edu>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Daniel Gomez <da.gomez@samsung.com>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add `module_params` macro
Message-ID: <87seupwbwe.fsf@metaspace.dk>
In-Reply-To: <CALNs47vwhV-DRzPbvE22vefaROmjj_5SCLuyQrfKvy=Q4Ou9WQ@mail.gmail.com>
References: <20240819133345.3438739-1-nmi@metaspace.dk> <CALNs47sF1o4x-=wPdy6c520-sCX_+sA=158MMP9c0SByKvwXfw@mail.gmail.com> <875xrmxdzg.fsf@metaspace.dk> <CALNs47vwhV-DRzPbvE22vefaROmjj_5SCLuyQrfKvy=Q4Ou9WQ@mail.gmail.com>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: f538f8390aaa0b57d7575c91ccf1865765f47b95
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Trevor Gross" <tmgross@umich.edu> writes:

> On Tue, Aug 27, 2024 at 10:00=E2=80=AFAM Andreas Hindborg <nmi@metaspace.=
dk> wrote:
>>
>> "Trevor Gross" <tmgross@umich.edu> writes:
>>
>> > On Mon, Aug 19, 2024 at 8:35=E2=80=AFAM Andreas Hindborg <nmi@metaspac=
e.dk> wrote:
>> >>
>> >> From: Andreas Hindborg <a.hindborg@samsung.com>
>> >>
>> >> This patch includes changes required for Rust kernel modules to utili=
ze
>> >> module parameters. This code implements read only support for integer
>> >> types without `sysfs` support.
>> >
>> > Also, I think the subject line needs an update ("rust: add
>> > `module_params` macro")
>>
>> Well, it is still what it does. Plus few support types. You think it is
>> not descriptive enough?
>
> Maybe it should just say 'Add parameter support to the `module!`
> macro'? The text `module_params` doesn't seem to appear in the patch,
> I was looking for something like `module_params!`.

Right, I'll change it.

BR Andreas



