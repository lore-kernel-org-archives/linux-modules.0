Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B192242D9D;
	Fri, 13 Feb 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014382; cv=none; b=REN1Geuil+s+cj0h33RO0VMHvbihc3vcCHcyDZnY5PZMo1eEqqSa0QMxYrlICqQyCTIkaez+m/Qe8ROZPFdHzm7s643Mz835t2lT5B3fvHm3J+Z1rh6UGFwF9esplb6FNPodzrKrzvYT0CPivSj/YXprJxpYm1iNBbUIw6/We90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014382; c=relaxed/simple;
	bh=zUGbf2JusS0zvsi2fS+3b4Wc746QajE1SGO73wz1UFQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QkRgWSgK7oO9gjrlXyQhh/DWP1zxZY0WcT/oe5kuXpQ58lxAt5oQT/uqnOS4sL3OSOdtaIzusine6lxXgd9/YfXSjW4JH78VWBQ9RJSgVyl8yFTneuEizfoDqdF7tSTGokpfaz1svKT4HkmpTH3Xp1eGzk/9g4hyrtwWdSGeeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com; spf=none smtp.mailfrom=opensource.nslick.com; dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b=Vv2yUIyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aV48Ur9F; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b="Vv2yUIyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aV48Ur9F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6EDAC1D00094;
	Fri, 13 Feb 2026 15:26:19 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 15:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1771014379;
	 x=1771100779; bh=zUGbf2JusS0zvsi2fS+3b4Wc746QajE1SGO73wz1UFQ=; b=
	Vv2yUIyuaXcrgGhDQKZ7iBtfgOj/CWU/5m+LIv3yS+33JrEncfs/ErLzhun3EhaT
	KYAVGObdNutd9vG56U+UnZxGxoqZfGee+/L6h3Iww2dvjgP5II7giD9tDFE5Dz+o
	2LP/mrw41uZTuZzwrLXT9z+HnZyt3FTHQv0IOj/6nlSKk+VU3wzBQn3jSEist2vy
	1xXP0jhSP4yHCCPJmnMgLoe8z5wP+bKZy9mkAPcsSHhdtxGXzJcRYlTVFFn+t8rl
	qdKQ4uImz1+z7CrUmPXdF0VUy3iyDpGiy1lkt5e660qn9Ywu61EAS2ZDcp25GmTS
	knmeaLwOTdY83VEa41ocQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771014379; x=
	1771100779; bh=zUGbf2JusS0zvsi2fS+3b4Wc746QajE1SGO73wz1UFQ=; b=a
	V48Ur9FWdOenMMCIMy1ylLJrLRKyvnFhYO3SlHGDagZEAHZo0BXIJW/vUmG3vinK
	Eb2YUASgxdytxn4W5AYRBeObDIbCzwL1TzOJjFX9axMfsVjjJsxEunIyCvNc33/z
	mhRPUG5fF+ARReOuMg0fzPGKJXDdj2IWbb7pjHAleT79Nw0LINGAQBUiaOAfk/HU
	DY0ChARpudUszzl1YejObXJ/5AdSXWmzWLchkqiMZsdXoZRPbD6G1ZxZIfqI/v46
	Yr2qjjsuMMVROvJdpZcIC+qb/qGEJsqMTTpz0y7RpkGO37krwDieYw4tAJnfm3OE
	VsxQWpL4UKSriTlWHp1BQ==
X-ME-Sender: <xms:6oiPabuysqSYU1_3inuyXoew2d9N2SZRIOXmRkanzEUTdAllOi7M8g>
    <xme:6oiPaXTvnHa_TgNJkBxeZPLY-8AhJSllKGYG21r_Pi-8jwS_fNM9PtFz6W2ArNePG
    UCLJulEznJr8Jv-U1_4H9Vl7cTE2FM-mDrp1XSc6JtCx3tIPwpiFvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfpfhitghh
    ohhlrghsucfuihgvlhhitghkihdfuceolhhinhhugiesohhpvghnshhouhhrtggvrdhnsh
    hlihgtkhdrtghomheqnecuggftrfgrthhtvghrnhepgfejtdefhedvheetiedtieektdev
    hedtfedvgfeuveevudevtefhfffhgfejhfejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhinhhugiesohhpvghnshhouhhrtggvrdhnshhl
    ihgtkhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrthhomhhlihhnsegrthhomhhlihhnrdgtohhmpdhrtghpthhtohepmhgr
    vghnnhhitghhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghmihhtohhlvhgrnh
    gvnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopegurgdrghhomhgviieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnh
    drnhgvthdprhgtphhtthhopehpvghtrhdrphgrvhhluhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:6oiPafT-w9cBdUk9Rlzs95hyiUbf4qdOd02KCSJAKQ2kQrwypuAAMw>
    <xmx:6oiPacqYV40Wu3vpO8Srwj9sUpJHpzZFrKdpSkLrpwTKtbZ01EypHQ>
    <xmx:6oiPaR2llLeOVVSXWwDQpCDlCDwh7HQmRjdBlVW8wHsKIfRAyC_jMQ>
    <xmx:6oiPaT7Gj9Bbv4LDdn6KLstm7PIrfAEBDdIpu2Sd018LQfY1oDEoQQ>
    <xmx:64iPabrvYBzM5KzAkAD1IG9akyjCacIts7vi3WCHSOjmla2X8tBnnRSq>
Feedback-ID: i78f146c6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A1EB2160081; Fri, 13 Feb 2026 15:26:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHZd_PBxTk1F
Date: Fri, 13 Feb 2026 14:25:42 -0600
From: "Nicholas Sielicki" <linux@opensource.nslick.com>
To: "Sami Tolvanen" <samitolvanen@google.com>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>,
 "Aaron Tomlin" <atomlin@atomlin.com>,
 "Matthias Maennich" <maennich@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Randy Dunlap" <rdunlap@infradead.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <5e1e7615-8ebc-49de-a918-6d96dbbea6b0@app.fastmail.com>
In-Reply-To: 
 <CABCJKudKtrVCUcKRFCHfAyCCA43=gni0iB4mdL5b+176Ky2UPA@mail.gmail.com>
References: <20260108044710.33036-1-linux@opensource.nslick.com>
 <CABCJKudKtrVCUcKRFCHfAyCCA43=gni0iB4mdL5b+176Ky2UPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: expose imported namespaces via sysfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 13, 2026, at 11:44, Sami Tolvanen wrote:
> The patches look reasonable to me, but I do wonder if examining
> imported namespaces is the best way to distinguish between module
> variants. Is looking at /sys/module/*/taint not sufficient for your
> use case?

You're right that the example in the commit message is bad; it's true that the
taint bit is strictly mutually exclusive with dmabuf support, at least for the
way that this evolved in the nvidia open module. This is a patch I had in the
back of my head for a while, and the details had become murkier since.

The actual problem I wanted to solve with this was not with dmabuf being
conditionally available on the exporter side (where the taint bit, albeit
imprecise, would have worked), but with determining whether the ioctl was
present on the import side, which was only true from 5.12 onward for uverbs
(commit bfe0cc6).

So on eg: a system with untainted nvidia-open on 5.10, it was viable to export
dmabufs from device memory, but ibv_reg_dmabuf_mr would fail at runtime because
the ioctl didn't exist yet. The workaround for my specific piece of middleware
was just to call uname and check for 5.12+ before advertising dmabuf support
back to the caller, but this left me feeling gross.

In reality, this patch doesn't solve that problem, because any system running a
new enough kernel to have this patch will already have support on both
import/export sides. But it's what made me wish this functionality existed.

Why I still hope you'll take this patch:

1. cheaply exposing module namespace imports under sysfs can be useful beyond
this specific situation. The kernel is already tracking this and validating it
for other reasons, so it's easy to also just expose it.

2. taint may not always be mutually exclusive with a module namespace import,
eg: in the case of uverbs above.

3. currently, the only way to determine whether a module speaks dmabuf at
runtime is to hardcode module-specific priors around the kernel version and/or
the taint bit, or to link proprietary vendor libraries and check for things
like CU_DEVICE_ATTRIBUTE_DMA_BUF_SUPPORTED. Exposing this under sysfs provides
a cheaper way for networking middleware (that doesn't usually allocate device
memory itself and largely wishes to just blindly plumb dmabufs fds from callers
into some importer in a vendor agnostic way) to determine what modules are
in-play during initialization:

> user@host$ grep DMA_BUF /sys/module/*/import_ns
> /sys/module/amdgpu/import_ns:DMA_BUF
> /sys/module/ib_uverbs/import_ns:DMA_BUF

Critically, it can do this check without needing to link any vendor libraries.

As an example, libfabric currently contains an enum for heterogeneous memory
types, spanning ZE/ROCM/CUDA/SYNAPSEAI/NEURON... but libfabric doesn't need to
allocate device memory itself (it is provided by the caller, hopefully as a
dmabuf), and regardless of what module exported it, all roads will eventually
lead back to a generic dmabuf fd import ioctl for the NIC.

Despite that, to prevent memory registration errors at runtime before they
happen, it needs to probe support for these memory types at initialization
time. Today, that essentially means needing to link a new proprietary vendor
library to query dmabuf export support using a vendor-specific API. But without
any existing mechanism in the kernel to query known dmabuf importers or
exporters, even a suboptimal one, this is what is done in practice.

Best,
Nicholas
