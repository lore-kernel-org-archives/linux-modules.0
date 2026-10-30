Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337366;
	b=FSnale1fefh6WfnguzcTRcY6ZxIXPqCmVCIYzyClkDmH7FByz21l5PEMa0XctOU+qcP/
	 SUoc2qqOpdvtC/otrNfaCGQaYHYVymZAXMLdyxjMGp+BAJPTS3g93h8dNu/bLyvzCYtXC
	 1DK0+ivyO47l3/6pXbHLmfwjJ/vviOhu1FHO0HRI8ab/SALQkYGGYVBw2bI+oudEcpEgx
	 HJHmEChqAYaowuydDFHKYrCGiyu43iCU1gEk2nBTxEA61BoLeTDk0uFuoM6RMR6IMZyhl
	 GYMkyAKEl474IhbnuMWCK0Gkq8iJC8HXV0qyNkfIFDCwNZWBi0MS/r//uGAYMfdwVXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=avuF1Y9mBOLiqs6rbP6YfufHWxWws6rCLMAuFNQeB0I=;
	b=KFtbD5K954BJZg3stWOLFZnYaJa2DZfxN554KsZd3iZqydS3ZQYxSo68Um9V02QCI49L
	 GWM5xq/1JvBvCcFnyJXBI8OH/eIWz13TXLCpixB/6uA5Cxl61IbW8XDe/aKFCDInuGBhT
	 79ysmB1nFmejzUU//2230nyp9gmiW0ZNgYt+f0W/wJgYSOimMoidsYb+vw5AuZm09gZSA
	 dXei5KUrXYyd+4GQwh8d60myip93KABEiVDMAZZbjGPWmdbb1npY8GNrbuqhZUH4BtJ6F
	 DbjbqobyDj5T3tBl2rBCvy6Jp/rQj+9cXOLTv219ircMZPQh2XyNG7zWjjJVXM1R7oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWLYRQf+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA73606A31A
	for <linux-modules@vger.kernel.org>; Fri, 30 Oct 2026 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWLYRQf+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF771F000C1;
	Fri, 30 Oct 2026 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793337365;
	bh=avuF1Y9mBOLiqs6rbP6YfufHWxWws6rCLMAuFNQeB0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWLYRQf+BtN6+4SA0BwUPj9QN9KycMnXsRAUVS8bCVPQQu/fXNBIQyfWRHsAV3U27
	 emUT/+HMh/g9j04qP2MPlL23zy6eb1RUGvaXJI1NqnLPgreZsw900DJniF8LniNkrZ
	 ICwQl++MMxYZIndAW/j/+gJIFRINJMGoaibpscpeCMEL4yfMcuafQlIPjM3YZVWhmr
	 yBBaJycRpbeEZbLaxFZHcf7R3zn/sgLT5RJ78EFsLaIMoQik7c6ki59IrsZVrMmCuB
	 NrbkDzUZ+Q4kCB1j4EqVATK6xWBG8kERPUb0P3zJlJwEUYJ0bRfoOlsAg+syaSSA3C
	 RnqR3mS10h6TQ==
Message-ID: <sashiko-outbox-190549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] module: Fix use-after-free in module_put() tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <an3o4dzjwt6p3wt45twtqsv2t3x527srauhcqv6u7uxtt7zz3k@22ye3vb5tf4e>
References: <20261019034857.654569-1-atomlin@atomlin.com>
 <a5e66dc8-155d-4eb1-add5-8c182879cefb@suse.com>
 <4ex7fuogdtmtxil4i2bzx3yqnkqgb2x5wxysqpwapauohmcok7@jvaytjn5fo62>
 <f7fe0439-d123-416d-b6fa-27a6dcf25d39@suse.com>
 <an3o4dzjwt6p3wt45twtqsv2t3x527srauhcqv6u7uxtt7zz3k@22ye3vb5tf4e>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:16:05 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] module: commit message in module_put() fix is a raw email reply wit=
hout Signed-off-by
--

commit 37bb54444936a36339279161bf4d23fea92a7c7a
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Fix use-after-free in module_put() tracepoint

This commit updates module_put() in kernel/module/main.c to wrap
__module_put() and trace_module_put() in an RCU read-side critical section
when trace_module_put_enabled() is true.

>     module: Fix use-after-free in module_put() tracepoint
>    =20
>     On Tue, Oct 20, 2026 at 05:22:18PM +0200, Petr Pavlu wrote:
>     > The trace_module_put() tracepoint is used only for debugging. What
>     > tooling are you referring to that could be confused by changing the
>     > recorded refcnt value?
>    =20
>     Fair point. Please ignore. I have another idea to avoid a reference c=
ount
>     that is off by one.
>    =20
>     > Normally, module_put() is not invoked concurrently with free_module=
()
>     > and doesn't need to synchronize with it, so an RCU read-side critic=
al
>     > section only adds overhead.
>     >
>     > The preempt_disable() call in module_put() was previously needed be=
cause
>     > of the complex module_ref scheme, but that was replaced in commit
>     > 2f35c41f58a9 ("module: Replace module_ref with atomic_t refcnt"). C=
ommit
>     > cb0b50b813f6 ("module: Remove preempt_disable() from module referen=
ce
>     > counting.") subsequently removed the no longer needed synchronizati=
on.
>    =20
>     Agreed.
>    =20
>     > The fix is valid, but I don't see a strong argument to introduce an=
 RCU
>     > read-side critical section in module_put(), especially just for
>     > a tracepoint that will be disabled 99% of the time.
>    =20
>     How about the following to ensure the fast path incurs zero RCU overh=
ead
>     when tracing is disabled, gate the RCU critical section behind
>     trace_module_put_enabled():

[Severity: Low]
This isn't a runtime bug, but the commit message body consists entirely of =
an
inline mailing-list reply rather than a self-contained changelog, and it is
missing a Signed-off-by tag.

Could the commit message be replaced with a standalone explanation of the
use-after-free race in module_put() (where atomic_dec_if_positive() drops t=
he
final reference on module->refcnt, allowing a concurrent delete_module() ->
free_module() path to free struct module before trace_module_put() reads
module->refcnt and module->name, exposed after commit cb0b50b813f6 removed
preempt_disable()) and how gating guard(rcu)() behind
trace_module_put_enabled() pairs with synchronize_rcu() in free_module(),
along with a Signed-off-by tag?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/an3o4dzjwt6p3wt45tw=
tqsv2t3x527srauhcqv6u7uxtt7zz3k@22ye3vb5tf4e?part=3D1
