Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695170;
	b=LWdQmX8eYDbb5/ujBDqGU6WiQJ5ShrqQIZuHQSvrdP6eFLdb/kKRWDsAg1dDpMFCgi0l
	 4BCWv5E8Kg20lIWTWXgGJk3CFtoZWJLjn+s/lVBZUeSopMz8z7Z/08dEElLAMWMPBmX0M
	 cvvZn/Jbyxs56fYsePH2O/nypmkm4sUgc5SjhJMG3gtyxC4PkK15ut0N7dEYlIw9u0/z6
	 RSETGvjENyf1BCuB+6YVZLMx8FxQMO7CnmJhQFIBCO1AESY+qTAgxGok6N+XqX1In7Dcg
	 SeIP13BbrG4TQIdlyLO+XitmQoHdvFwlpw7F9hxfXPvBHVHtDKzODhQ06xzSrNTVBWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YPZPFRy4wwMfoKyTeqUO2oY/sl/+MxEWt9s6dtZw3Tk=;
	b=ohkd321BjzSPhSVIhl8GgbSAbivJIB7jinFfDb2LHg7VhSWMFhNxcqQ4YVB+8k59lSVn
	 sRWLQtAOSZLws9JuGGzsMuOVUo5JFPQs79wF/VjUWuQ/KPCOyJXopVyGikgepqCAx2e1J
	 QvvobQR1yV7kkQq7p4NPjmshsWnJWLXMNf9sJO9mAl93W64rRjSTlGO6mg1aoe0i3kkY/
	 igyH7U23y4FpAqnUw/j6uPy/sjiy9YR4WIam0MdoIAPoSuNtTZ9LZZnYhwRgwGvmSfxqc
	 R23/E5gM4+lJxQZ4nyNK4SMWCYo5sdgWL8vCJeEx9XDGqvA4EnT+paZB6t+cjNE+eXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uvb+pmrq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5F606A31A
	for <linux-modules@vger.kernel.org>; Thu, 22 Oct 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uvb+pmrq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2331F01825;
	Thu, 22 Oct 2026 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695169;
	bh=YPZPFRy4wwMfoKyTeqUO2oY/sl/+MxEWt9s6dtZw3Tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uvb+pmrqV5lXISZ0c+ncmbYJ14Fs8aWrZvc19qjjvnTYfcvZBK8CskAFYhHTCp8aL
	 vgeyCdSFdGVUvGLX/KTXeRwVzH4yba87nJo72HrujZ+GhAk3srA7CGbM9B9+53Iu+9
	 vOjsGBmKteUqF+vsWhKr5MUS/09la7h73nFcG/Vloy/rvxx1K6R6PrEFkAkeeeq+ed
	 iZi7Z0kn2XAQFoZ7BbG9Tz53HRmBTWlSQ8Apwy0IY6xT2WebHT1yT/3qxntTNYi+YZ
	 JRkxhZzr29Uwv51bQp+PfAc7+3YLSi6jI75jG3N7FHoKrGrZMiKOVhNge2tc5T2ckf
	 q9Lgg77rrMk5A==
Message-ID: <sashiko-outbox-181939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] module: Fix use-after-free in module_put()
 tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261022184517.66438-1-atomlin@atomlin.com>
References: <20261022184517.66438-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:52:48 +0000
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
- [Medium] module: trace_module_put() records pre-decrement refcnt in modul=
e_put()
--

commit 2c168275e42fc7a4482d549cb0c9f1fc9f71e395
Author: Aaron Tomlin <atomlin@atomlin.com>

module: Fix use-after-free in module_put() tracepoint

This commit moves trace_module_put() before atomic_dec_if_positive() in
module_put() to prevent a use-after-free if the thread is preempted after
decrementing the module reference count while the module is being unloaded.

> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index f1392c10907a2..70063fea52d03 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -954,9 +954,9 @@ void module_put(struct module *module)
>  	int ret;
> =20
>  	if (module) {
> +		trace_module_put(module, _RET_IP_);
>  		ret =3D atomic_dec_if_positive(&module->refcnt);
>  		WARN_ON(ret < 0);	/* Failed to put refcount */
> -		trace_module_put(module, _RET_IP_);

[Severity: Medium]
Does moving trace_module_put() before atomic_dec_if_positive() in
module_put() cause the module_put trace event to record a reference count
that is off by one?

In include/trace/events/module.h, both module_get and module_put use the
module_refcnt event class, which reads mod->refcnt directly inside
TP_fast_assign():

include/trace/events/module.h:
DECLARE_EVENT_CLASS(module_refcnt,
	...
	TP_fast_assign(
		__entry->ip	=3D ip;
		__entry->refcnt	=3D atomic_read(&mod->refcnt);
		__assign_str(name);
	),

In kernel/module/main.c, __module_get() and try_module_get() call
trace_module_get() after incrementing module->refcnt, recording the
post-increment value:

kernel/module/main.c:__module_get() {
	if (module) {
		atomic_inc(&module->refcnt);
		trace_module_get(module, _RET_IP_);
	}
}

With trace_module_put() now invoked before atomic_dec_if_positive() in
module_put() when a non-null module pointer is passed and the module_put
tracepoint is enabled, TP_fast_assign() reads atomic_read(&mod->refcnt)
before the decrement occurs. As a result, a matched get and put pair on a
live module logs the pre-decrement refcnt on module_put instead of the
post-decrement refcnt.

>  	}
>  }
>  EXPORT_SYMBOL(module_put);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022184517.6643=
8-1-atomlin@atomlin.com?part=3D1
