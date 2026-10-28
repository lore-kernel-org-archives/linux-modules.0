Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202106;
	b=k+OimrPrxnMJ4uB3BZZ4I2GMCk1Zw4tOxrIEdgfEDvUQ9rSAy1hCNJsdjh4R8xgdLrL/
	 elC18SAa4RWBhbeAL2B7b3FWqboEIv2v6fv2pvcciBK0nA7fMrDlXScpopRMMf7MGVUaZ
	 x5WFs/orNwg5sfKTmvdkTy8blaU58puB+brlO3z4wb/mdVDBHz5ndYo9w5ltTQrZhaPE2
	 WHewy73xvf5Pe7JNqfRwpz+dNoSfL3AnJHH4qZ92szhPWvknHZWN+URYdKOWWlwd8BJvl
	 WZL1RLXPrEFzOyzH7RGUKT/0wVwLcJD0/SJOjmbRtYEU7guQ9MWCaGUddmTAlNVQPtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202106;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nBjRxj9zvpUWBYieU8XuvaoHIUe7KPpEifpHAoXCHno=;
	b=5Nvr1dLWTagYnVrH7CKqYZN+Ve1918DYH7H6IqnXeLKpOvMCVBCF9UznSJC9seRX5R9v
	 zAM/tNtI7VABv8OL/Z7dgiXfUs5enIA1AJXuupxfbinyRbGTQ3yYwXKsv0LK0K4Nf2kZr
	 DXdE+cpBHOrhfWFuXahAROKDyHQodBEJTeilkfgJ42S04fAEPFfHTH7jzKV57rvNVPly/
	 pEPgcfG3+3xIrrtRxZtX9L0b7Nr226/eENK+6/zzbkclh/pX1qp/FAj7auAfXJm83aYPu
	 B/QrX6k23d0tJitKBiDkziNDevgDVHqJnMeSSGtrXMHfu8ZLTmY7HpKLbp/FFoPRijQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9960A2608
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 15:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B9960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DDC9FEC0307
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 11:41:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 11:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793202103;
	 x=1793288503; bh=nBjRxj9zvpUWBYieU8XuvaoHIUe7KPpEifpHAoXCHno=; b=
	FVpzlnASFLIgMhSAokz5WxVtPsXYnzyL9VnakQ8d785I6sUIh7B0i9rGgfOl3zgb
	M9jrNUXFhfDxhrEQue4mWL9J+3weVIsSZKD2AGScxN5owyVbl1DZpO85rvel7/I1
	BrCf7L/aLiNX412JCoddPsLufqWg3OMixQuGeRzZyBWjClhmqJnoCzaYeWflH51U
	J6sXRjylQK7nL5GuERS71vGqHQNJ+Yqamnzd+oSarhdumxuQi+rbbT0F732Ua9pU
	qj0PnA57KvJR1l/yHwfFl42HmXtRB8xA0o7xfHrF9K/1w2LTGFk3th4uvLF2NRoI
	6OvRTENrsvHfV/fOaq6IZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793202103; x=
	1793288503; bh=nBjRxj9zvpUWBYieU8XuvaoHIUe7KPpEifpHAoXCHno=; b=w
	lvapL51zA89BkW/sxkEZw9DFwV94KnZk/BZ0+s+RpDfinhDwGrIxfgTjm84TXUq0
	sWkRA+oMDT31Ri/WVn8qQaI1ww+DXqgMR6OWYUWgY6Bj76QpG9xPyU5MgoUfQrLk
	5i+DpSuunDtFApEt15d4BHepQ1+ktFsQVrq94aIDqx9l720XFlp35pDOcjHBUKzG
	vYsn/VbyHB6YA4+WufAjQ3At7PXrs+VbzrTKSuq9gmZAOI1+P4zqW324+H4X1Qd7
	qJM1SHpXZXECNI2OEPRPpw7IIwLuXqkbxtWruqtBC0DTPV7dxjJLcUh2XuV7Hdp1
	KbJC/IRzA6C0BvQy7zukQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793202103; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:XZmS7w49XVjfZut0LEcXN0GDBmqXC2BBPAXUAEESU1dBUs1
	iDFNQzGXNbku1ZXIP3QyVCV31HYpvKlfFGNXkTONiwVC3xnLsDY/eNuW5pl/0577
	c4sgzjYvjZIPWvbGxR5J2zlU3/ZXLIoL8iQVxKWeopYA/Q7AakU1bPWZeTRdrZ5P
	K8hcqMVXo1QvLjNLxh/ByEX8WSX50Jcbf0o+eKsf4g7S6fY2R3MCWQmdW0pQ3BmY
	VZ7g0JEb0sX4ay1li5wf1vH8sl3xePdLMS6XGou/mqe6V685gWWluPOb1s7AgQMN
	Q+4btxCKuhTsRk/5HM5h48L2D5eh4x+2xH2jVOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LbaJFfvktga4aPohWhLRqD5XDHeLFbrHeHEX9cs/bjY=:Ao+SYeV4Fwst0FguSJhVXFa1iUPte2lvw40dXbYdsA4=;
X-ME-Sender: <xms:thfiaihfluVol6rg-FGWHMORXsY4fsgyeqW5UIQf30ztzcl-5MrAyw>
    <xme:thfiajx914QKVKWi3mzbHIFcfGf3figU7XmgBTJBHcIdX99RRnSo789w9MaRXjYot
    xJZzZlGL92cnyOwa2gstAKHtKiSDtTO_R9KDhdHH3Fa2LiB3rjdIUw>
X-ME-Received: <xmr:thfiai9qWdMYuGf8NueSZAhPm39FP8IZ9nuMGulKASzToUqclmalSPRg73aZYA>
X-ME-Proxy-Cause: dmFkZTGpkGeIHBa7luaXBdHEkLteeYnKFNz5z7xJ/WgARwQ/bjfzIr6g9EFyMFBeIIt/3H
    dae+QqGnTr2u2vKK2rCOBCOcBLdyoqXayi6/RfPxoNfJSSMj6iuaGmWTBooZlKMbL6o6Hu
    dPpxxoi5wXr3tlAqnVWkvTk/5lsu0ZkbhnRYCNCpQNIpMTa8ycE7RedAyqJvgXv1BwuwFP
    D/qnUhITaiyi1RMk4C49tPO38F4cpfnoREJ/bR3Kl4ysaGYlAj2skuA2XPgiueCFEIQamF
    D5+QtLIcs27z8qWkd6OVDwEm8bue7gaDNmrCJAAIcdOt/A42TK64KNVVzmQG35jP6W0Ob2
    9tMrsRBiApamE6nyVJld0CmaDkJduyQtAIM6HvPcMYKsbYiBwREblVe203pddCh3RV1ECf
    D1RKRCgPAuSey2qObDDuJeW/VCh4Ma/I2TwGczA1C6XUtLgLQb8Go3gj0T3zOic9pP97lX
    d9i/mIPFZ+Whm2zjUbM7nGMS3bNpBYwDrsg/nzD6ORrtn34d6482FloFrVjBqMAY2cSYya
    t/I0FSQbvE6/bRSMozKwuLnpEdoD0U9FFDDEQmE+gvCxDv9LQuBywaajkqHrhUnYcEklc3
    oDaKdXAkZTDVzzh10hEb9ghYD72MwkCLEzhs6E96QiKhhjg/KbBDhQRsPxpg
X-ME-Proxy: <xmx:thfiajIGaz02nZq9ogfRr7EslNQisxspDEtEpply8CYGFCtG5LkFxw>
    <xmx:thfiau7RDDvJT57OJPQn2HyP4je_8qFPdv-lyJ_t0ZgmOD5QhHJsxw>
    <xmx:thfiagumjOsbvnn57Q0RPFk_Fio4VF5ZYBfD__Le5uT9m-ctfLTeYw>
    <xmx:thfiakZPCUYo1I8CgmGMJbZiVr2ckMXPWSvv6P36oqJrKS32uCkelQ>
    <xmx:txfial_gUUZpbUA7gcB8NhEWr_8iNpjXDJtLY4_FEa73WN0qEBiwKIVP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 11:41:40 -0400 (EDT)
Date: Wed, 28 Oct 2026 09:41:39 -0600
From: Alex Williamson <alex@shazbot.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Armin Wolf <W_Armin@gmx.de>, David Lechner
 <dlechner@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Bradley Morgan <brads@mainlining.org>,
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 Richard Weinberger <richard@nod.at>, Thierry Reding
 <thierry.reding@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261028094139.12ea7c16@shazbot.org>
In-Reply-To: <auILBqh9Ccv7ztid@monoceros>
References: <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
	<9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
	<2026092321-province-yearly-44aa@gregkh>
	<arOfHEsGGglNse7T@monoceros>
	<2026092348-victory-erased-0e5a@gregkh>
	<20261023181326.0dc2f7ed@shazbot.org>
	<2026102437-vista-unsoiled-b089@gregkh>
	<at34UOuYv3NtX36R@monoceros>
	<20261026225950.GD1685504@ziepe.ca>
	<2026102849-turkey-series-ac07@gregkh>
	<auILBqh9Ccv7ztid@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 15:50:44 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> On Wed, Oct 28, 2026 at 02:45:18PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Oct 26, 2026 at 07:59:50PM -0300, Jason Gunthorpe wrote: =20
> > > On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > >  =20
> > > > The more I think about this taint, the more I believe the commit sh=
ould
> > > > be reverted and replaced by a some stop gaps for driver_override. (=
Be it
> > > > a taint or better yet
> > > > https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a30=
8.1790612298.git.u.kleine-koenig@baylibre.com/
> > > > .) =20
> > >=20
> > > I also think this patch is way too broad and should be reverted until
> > > something better is designed. =20
> >=20
> > Fair enough, I've sent a revert for now, will get it merged before -rc1
> > is out. =20
>=20
> \o/, thanks
>=20
> > I'll rework this for a later release, thanks. =20
>=20
> Please look at the series behind the link above before investing time
> here. I think most of the ideas are already implemented there. If you
> voice your preferences there, I can rework accordingly and rebase on top
> of your revert.

=46rom a vfio perspective, the concern with the linked series is that
driver_override always taints.  That's the same regression we have
here; vfio use cases rely on driver_override.  Introducing a driver
flag that allows a driver to opt-in to declare support for
driver_override, but then taints if it actually generates a match is
contradictory.

I had been working on a series that allowed match to return a match
type classification, for example 1 as a static match (for
compatibility), 2 for a dynamic match, and 3 for a driver_override
match.  Anything other than a static match that reaches driver probe
generates a taint.  Also note that generating a match doesn't
necessarily result in a driver probe callback, in at least one flow we
haven't even tested that the device isn't already bound to a driver.

The bus level match function can filter and downgrade the
classification, for example PCI has an override_only flag in its match
ID.  vfio-pci and variant drivers thereof make use of this to avoid
becoming the default driver for devices.  A driver_override that
matches the override_only match ID in the driver table can be demoted
to a static match and avoid tainting.

I'm not sure I understand the rationale for focusing only on
driver_override though, new_id has just as much ability to generate
bogus driver matches.  It's also racy to use new_id if you're trying to
get a specific device bound to a driver, which is why driver_override
was invented.  So we end up placing barriers to the use of the
interface that we've now long recommended as the better alternative to
new_id, while leaving the gaps in new_id wide open.  Thanks,

Alex
