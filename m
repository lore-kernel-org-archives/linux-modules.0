Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBF3A9D9E;
	Mon, 13 Apr 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084152; cv=none; b=MInlKNfa3rHLYAM/7tPcJCU2Gd5tm2WagYJbYrgfOPsngg1pKOnFuF7r0f6x3bLZitpdvpjuDaJAqsYPa6gJw6Now3JlMKamH2upkKP7Q9xny4F50m31W3ft9zRXy3XpBr07zl75Hqcit8+Nu+asUbDLDJMkFXoPjeShI6DBRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084152; c=relaxed/simple;
	bh=Vq2KRSog1Xf66CJoAnk2zEn9spWgWEN0zOOQoL4SY08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sghArSCImhDSLsg2j70VYyxWs4d+xlqSzvTcdCLHyVsfwzO/43t+ypmi/1e3d3wmWk4Y/RGPK5m9C/3SicdFU3KRAvrjr8qE2Sh2bv7VbSYr/URjJrId1iAm6RZir+JHIJnNN2GvYc3TpltsLQ7UMBQyW7Ff231CDMjHhD712Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ONvWJkBv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwFc764f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ONvWJkBv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwFc764f"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D89B91D000A0;
	Mon, 13 Apr 2026 08:42:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 13 Apr 2026 08:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776084147; x=1776170547; bh=0snUOsgfxm
	fA2qUO/qd7PXd7l9x/HKVKTztbKhKqKag=; b=ONvWJkBvJKcVQIXDvu+BO6vx7n
	W34r7ZQDNIH8QDxmjCn7tJPigKt4zfo42+iAWZFMOZCwE3o5rc4MSxuh0y5wu6Ir
	WEtxVLiV6jd8KUZnvghy6sIfzq0H8wZ3MwF5rYtQNAKhd6lhWp1Z7bNyhA1292Lk
	aqbR2+59N/Jabr9ezhRX0cES7mg95Rv0NB073czAUU37d0b+Fw6gNcp+P88wCYF0
	Xm4vpaP5/9s52mOJgwtHa0GuQK6lyvZ8YEHVIxXl/KinDNQfSk+I8fGc7TrA8U5a
	WpJMSpvPeLZYmvdWcwT755WiLADMJVMdQXO87pbugVxZ83aDIobgcQ+e/gqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776084147; x=1776170547; bh=0snUOsgfxmfA2qUO/qd7PXd7l9x/HKVKTzt
	bKhKqKag=; b=VwFc764fP1G+oG1aoaUFSnOLKFp4HSXpFa6cG8H1AJThpRKl9zk
	KjuDLaDmbmH59WSxAuRTNEGNZmHahrCq0lAUOvbsYljtdbnLk822T8FxWPuj8gMB
	YhaRkON2MN988K1iOz2SS3h4dfFtDctuaQyzeS4Uncu30SQHYMHhXI6LeAUQrIoD
	WqZMYRUk5DmWEibxS3ZICIFUPPwax2+KPyQfoUT1GLW3nIQ1LguzyZ1EeXl9gA+p
	MYJ0/T+rgrJlMqe2nsJcdHQqkSOjMtQuSukMNY19PREOVXYOtI9LzqPgp7J7R4gP
	Xs2z0OXJkCXBECkPTgp7OJJGA6eNfPId7rQ==
X-ME-Sender: <xms:suTcaSJcVVdbiKfnSQF1USaSiC3cN1hcIifOC23BjHvR1SKhzwbEKQ>
    <xme:suTcaZZnc6qrZuPa0Bz4VBYoDmFKm9paN_tK_N67OeP4TZkAubnSwcWo5vbPH_ZmU
    1xTghkGV6QZG37MANWRNQIkzAOqtOQ7fzNcy_5FG6F94wbi>
X-ME-Received: <xmr:suTcae5z3BIAYV4RuXSZNsFO_si2c89QbtDJd0IzRkilonLH2fRbF_UCbVSJ3EAdIP7t0VozRRL8JSthdgpPZK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeefiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeifvghniihhrgholhhirghosehruhgtrdgvughurdgt
    nhdprhgtphhtthhopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gvthhrrdhprghvlhhusehsuhhsvgdrtghomhdprhgtphhtthhopegurgdrghhomhgviies
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhhithholhhvrghnvghnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmohguuhhlvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:suTcaSJpXvd3G6Z-c5cEBONHfKhYoUxCiql2NUePQgnrRTmM4qbrGA>
    <xmx:suTcacb7Q4oF2LJyAt7NOvDUsUQaInlvE7MM_Hok_Ts_RIpzE7f3fA>
    <xmx:suTcaSw27d9cTXsZUuvPXMNouW3wX3vsB01HmCJVNDaeW2dCYP-EzQ>
    <xmx:suTcaQWf7LuZyKwngJq0heudaLEVihKVhoHE-xQ4Gf9g078TJI9bug>
    <xmx:s-TcaTaMAWDLq4XRRI25FfUCYZ0ks9rvXUWTQFWx8CjLDoVXvGOC3V7n>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 08:42:26 -0400 (EDT)
Date: Mon, 13 Apr 2026 14:25:44 +0200
From: Greg KH <greg@kroah.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	ojeda@kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org, atomlin@atomlin.com,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] rust: module_param: support bool parameters
Message-ID: <2026041323-fled-sharply-77c0@gregkh>
References: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
 <XkCBdVOQy3WcLA_L2YGegyYzAKKeqrm7gLpNUE8Y2Yj_9WksIbIc3U8lKkN5BfYo8zLmhZzMZq9vwC43s_nqpg==@protonmail.internalid>
 <2026041118-croak-serving-ff5e@gregkh>
 <87fr4zvzn2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fr4zvzn2.fsf@kernel.org>

On Mon, Apr 13, 2026 at 02:00:17PM +0200, Andreas Hindborg wrote:
> "Greg KH" <greg@kroah.com> writes:
> 
> > On Sat, Apr 11, 2026 at 09:02:53AM -0400, Wenzhao Liao wrote:
> >> Sorry for the earlier noise and for our unfamiliarity with parts of the
> >> kernel submission process, which created extra burden for maintainers.
> >>
> >> This patch adds boolean module parameter support to the Rust `module!`
> >> parameter path.
> >>
> >> It implements `ModuleParam` for `bool` and wires `PARAM_OPS_BOOL` into
> >> the Rust module parameter machinery, so Rust-side parsing reuses the
> >> existing kernel `kstrtobool()` semantics through `kstrtobool_bytes()`
> >> instead of introducing a separate parser. A boolean parameter is also
> >> added to `samples/rust/rust_minimal.rs` as a small reference user and
> >> build-time validation point.
> >
> > What driver needs this feature?  Module options should be very rare
> > going forward as they are 1990's technology and do not fit the "modern"
> > kernel model at all.
> 
> Rust null block uses module parameters, and was requested to use proper
> boolean parsing rather than overloading u8 parsing for boolean
> parameters [1].
> 
> Best regards,
> Andreas Hindborg
> 
> 
> [1] https://lore.kernel.org/rust-for-linux/abfK4eji5jKSeO_W@google.com/
> 

Ok, then that needs to be said somewhere, and ideally, have the code
that uses that as part of the patch series.

thanks,
greg k-h
