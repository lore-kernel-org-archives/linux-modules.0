Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219125;
	b=XToMYohTvTTdMksqq6pH9E5gLgH4ntFPF4QdzMqx+AakM2pHcIcBgPDzjqPvNWlZHo5u
	 74ogzxiiQTonhhqKDy2VksjBCZpMjlXkyGXqm9oMp7SFJ3R0szbjMn18c7ZAvbBtKBhu2
	 o8gzcuqX+LLJwt37S6XuGb4IjU1CW95SQ/lioOykSnk6KeE0SsAVtG/hkZQJHpRAH3RFP
	 hZALRzV3xshsjFarcwVe2mvfQy/d+kP9US/fms/stenY5nD6xvh1mIXzMx+pk3iJ2Sk9f
	 xYHH4EU47imPrOFipB4avLXLal2RyQWs8Pc91qJ8wRgokcCpTjUcGEbRg6vVJj1lvxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vx4OFLZ3cUnJed2hLZJBc40d75gcy68pG+DU+7R4ubY=;
	b=F1Mk8xPAOySNBdSw9Mun0K6oROIP/JWd7tiD40iWS53OvbmgBKlfY2Bk+uL1MMe4L67x
	 5QZZ5FYwILSm6tI916HtlS7l8PCI/gE4rP2xh1J+IhUlZ/vBhkz+H9SXLiGpkjjbXNG7h
	 jK3jj87/PoDEFeUqD2YQTqPfufRdoY6/CjkGkjA7pvW76AYWqq/ht8AkBbvz2YxCjNTZ/
	 0RufMsbhBwlphWfZq8PcVismW3qzpGW+2LmggOXs7+5wi9LA5Qx+3r4y20bCRiccO99yp
	 QjagQih8TOVCJHXgODhsMyXKzRQVzqkxi/7rW3QX4f9iMPiMq+iNyQBAJ+3P17zJUlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkRAs3N+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25011606A31A;
	Wed, 28 Oct 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkRAs3N+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227DF1F01825;
	Wed, 28 Oct 2026 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793219124;
	bh=Vx4OFLZ3cUnJed2hLZJBc40d75gcy68pG+DU+7R4ubY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkRAs3N+b6aKi30KqRhXhuT6HfiOXlpaDXck4iFAQyztV8bEiwTkrz2Xq+ZK6bhjs
	 1BiCiCRoqH5/zfpRWSCRQ9uYv02gMiEZUs/wdNrOx8vylDa6WTUSZQXLJeSNG8kIgI
	 JSYWKHin0ikXPqnHolCmLZ4MrCdG8NF4/CCRHQFNktdouJNOzFZoqAC8U7VEQ+ACsm
	 7c6SXHBo3hqEjYyFYdTiKf0QxkA/QbfQ3byzPORasy3GT9ps5l1bIDf5XyED5fFBZM
	 KZgZ7T8Gv2zmiH4dsUjEBIpys8+56ltXhlPrukK3kO13cOyxUemYCNXc+lXGsjxFS1
	 6A5soN/J8YNTA==
Message-ID: <sashiko-outbox-188411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 35/39] dyndbg: add +c flag to count pr_debug calls
 without printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>, "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>, "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, "Jason
 Baron" <jbaron@redhat.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-35-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-35-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:22 +0000
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
- [Medium] dyndbg: race between reset_ddebug_call_count() and ddebug_increm=
ent_call_count()
--

commit 9bd6a53ec548939d0c4d27704bc80cf4e68b28ef
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add +c flag to count pr_debug calls without printing

This commit adds a +c flag to dynamic debug to count enabled pr_debug()
invocations via a per-CPU counter without printing messages to the syslog.
It also supports resetting the counter via the reset_stats command and
reports the total in the /proc/dynamic_debug/control epilogue.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index efc7a741008ed..027f7c31fe226 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -71,6 +73,21 @@ struct flag_settings {
>  	unsigned int mask;
>  };
> =20
> +static DEFINE_PER_CPU(unsigned long, ddebug_call_count);
> +void ddebug_increment_call_count(void)
> +{
> +	this_cpu_inc(ddebug_call_count);
> +}
> +EXPORT_SYMBOL(ddebug_increment_call_count);
> +
> +static void reset_ddebug_call_count(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(ddebug_call_count, cpu) =3D 0;
> +}

[Severity: Medium]
Can reset_ddebug_call_count() race with concurrent calls to
ddebug_increment_call_count() on remote CPUs and lose the reset?

When userspace writes reset_stats to /proc/dynamic_debug/control,
ddebug_proc_write() -> ddebug_exec_queries() -> reset_ddebug_call_count()
directly stores 0 into each CPU's ddebug_call_count from the resetting
CPU. Meanwhile, other CPUs executing +c callsites invoke
DYNAMIC_DEBUG_BRANCH() -> DYNAMIC_DEBUG_COUNT() ->
ddebug_increment_call_count(), which uses this_cpu_inc(ddebug_call_count).

Because this_cpu_inc() only guarantees atomicity with respect to the local
CPU rather than cross-CPU stores, a remote CPU performing a read-modify-wri=
te
can load its old counter value N just before reset_ddebug_call_count() writ=
es
0, and then store N + 1 afterward. That causes a data race and leaves the
remote CPU's entire previous count intact instead of resetting it to zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D35
