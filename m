Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75C349CC0
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693606; cv=none; b=rI/vYoQ6MO68OMQ4af0ikFKuT71lZshHYVPPIZg82JtQHDD0c1Nr64bVxlJldWWZrdaIpqNfWBDOyyuCMMUXI/4e6p9Kzz618bbwRqQibpr7NMMEzVujGpvMo27iPeUrkdZhjeUULlJRGHeCSumRl8mISqwLJgdE9yOZB4hYk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693606; c=relaxed/simple;
	bh=giAq7FDyqoxaBT+603zv9Sok+grw+xMZBUJgDPRp3aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgOUR573AK7KBzyZ/VDG5a1VH7iXwY/sDh6qaAXnJ0d6OIt25PhhbOZZC8M3NiNEs/HU28AW28q1PxsRsisdjfJaZOOtr1LyTTY2eanfeEkXjsek5yPRG6R+MXwaXRghQNKfJnDUrA1obv64VSLQII9Mxm4Sb2IG/Y+87CydKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/NglSyx; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/NglSyx"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-698ae260973so1373890a12.2
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783693604; x=1784298404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=giAq7FDyqoxaBT+603zv9Sok+grw+xMZBUJgDPRp3aw=;
        b=L/NglSyx3naR0OdxzYkiT6VvfYp1ImhpsEAusXue6uPmwOQkuFG4QFJG2fjjbJE1Ej
         0nnJuDvRBJpPVYIR9lRuS4V8MDp3+QSHd5vvZELOR18BtczqljDcqqb1O5YFxiXlnQLZ
         xNEZwse5O+RvdlYmztAu1RfUoKHte/PsxLwCqSkzF8rw5Un77UY7Xj42dpnlLXHCBLE8
         T7eYgP/wuLJGR+HPfFn5yLRQxhUfzaI+sSE8XPRoLyWaTbbTlK+0RLZLsM1iVKkWjj5r
         DVHdwPlZEWLV11F2d//pHGjUsnEVRQMQTfDhpAiTLydmF4Blj3vYgRcT2Es3pKbrBdt6
         RvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693604; x=1784298404;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=giAq7FDyqoxaBT+603zv9Sok+grw+xMZBUJgDPRp3aw=;
        b=diOv/myCCqkhOFD8i1KO1/tCTwtfT7CewgXoav7oGIu5IJY2aXGoHls8XuhrVpVDEF
         viOfcOs/lnkIyq89X9xXkoFJI7J07beHTsOOM2PRDGHMyERns3Hid2C5n2WKYwznh4hm
         syjIdjcfULDWUIH6SRyXTN9uTJym15+9L759MEf9H6OcpsbDHAJgCFsj5AsbhDh/ntNX
         /h4x0DsHhykhPUq96leBXQCLk1du8cpeVCgHMCR72cBre+pV67bwkdui4SqKOocwL+Vs
         z6dO000hqgsRDyQCA8ivVbiJlttu74vOwwspiBqevQ37XHIcDlBfTSY4uRaMhmdsa3oS
         uiVw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2jSoQzIsGUg+MLen+LbIhIgSMZqENtNmbUN71IQJbw9xvoO2jr4+4tiXbUp02yCyTSnSVIOXKhnorNyXj@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAxNArkDg0VkeTupvbCH3Htb6nFNxfkicRbFEPOfq297BJkPJ
	pBeZKY0v1y24lnlwbNr16GE82/RP8WDfbuW/bE0Yj7GgEXS1oyj4HSBGfLU4u1IW3aXbiO4xgk6
	FKhD1QDRiuGbcjqrkNw==
X-Received: from ejbym5.prod.google.com ([2002:a17:907:3305:b0:c12:5a40:bede])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3c82:b0:c15:e8c8:34f with SMTP id a640c23a62f3a-c15e8c80d9dmr351620866b.13.1783693602853;
 Fri, 10 Jul 2026 07:26:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:26:42 +0000
In-Reply-To: <30e500ce-e9e6-43cc-bbdf-ded7c0ae56cd@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
 <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com> <CANiq72m3w7L5CmAsFvOpSh_jNk4jL8+A4vz8GEp+E8FY=TJcRA@mail.gmail.com>
 <30e500ce-e9e6-43cc-bbdf-ded7c0ae56cd@suse.com>
Message-ID: <alEBInX9gD1M5NAr@google.com>
Subject: Re: [PATCH v2] rust: module_param: return value by copy from `value`
From: Alice Ryhl <aliceryhl@google.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 10:13:53AM +0200, Petr Pavlu wrote:
> On 7/9/26 4:13 PM, Miguel Ojeda wrote:
> > On Thu, Jul 9, 2026 at 1:48=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com>=
 wrote:
> >>
> >> @Miguel, please let me know if I should take this patch on modules-nex=
t,
> >> or if you'd prefer for it to go through the Rust tree.
> >=20
> > Please feel free to take it through modules-next, of course.
>=20
> Thanks for the confirmation. Queued now on modules-next for v7.3-rc1.

I'm seeing this error on x86 with latest nightly rust compiler:

rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramaEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramhEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramhEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramiEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramiEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramjEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramjEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramlEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramlEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_parammEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_parammEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramsEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramsEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramtEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramtEB4_() falls through to next function _RINvNtCs65fqAZscXCv_6kernel=
12module_param9set_paramyEB4_()
rust/kernel.o: error: objtool: _RINvNtCs65fqAZscXCv_6kernel12module_param9s=
et_paramyEB4_() falls through to next function _RINvNvNtCs65fqAZscXCv_6kern=
el6devres16register_foreign8callbackINtNtCsbtRzKR1rrUg_4core3pin3PinINtNtNt=
B6_5alloc4kbox3BoxNtNtNtB6_3pci3irq21IrqVectorRegistrationNtNtB1A_9allocato=
r7KmallocEEEB6_()
rust/kernel.o: error: objtool: _RNvMNtCs65fqAZscXCv_6kernel6deviceNtB2_6Dev=
ice10get_device() falls through to next function _RNvMNtCs65fqAZscXCv_6kern=
el6devresINtB2_6DevresNtNtB4_3i2c12RegistrationE19devres_node_releaseB4_()
rust/kernel.o: error: objtool: _RNvMNtCs65fqAZscXCv_6kernel6devresINtB2_6De=
vresNtNtB4_3i2c12RegistrationE19devres_node_releaseB4_() falls through to n=
ext function _RNvMNtCs65fqAZscXCv_6kernel6devresINtB2_6DevresNtNtB4_3i2c12R=
egistrationE21devres_node_free_nodeB4_()

I understand this is probably due to a new function in Rust stdlib that
is no_return, so probably not caused by this patch even if this is
triggering it.

Alice
