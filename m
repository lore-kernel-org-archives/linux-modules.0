Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D0284685;
	Wed, 23 Apr 2025 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421459; cv=none; b=npFrpNqWWmsiW37YVtcyGrACWfJpHSQuKynhF2/jU/efpIKNJqnt711344z9jpyCyDJC9payfqCmOeOkgl5C66XZ2tWg5HQk2EZ9v0j5TeUIxWwPsaFRIo3xldQWTMvz5cEi+bHuaXKGnPRRYhK4mhTn3IIuTq6LEnA7YMVEguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421459; c=relaxed/simple;
	bh=RLOU3IDmax4zTd10jqcY2sq4SEHMcbxI1llMeEizx/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENj0eJ+KddI+tWcSutrA21sq3ctO2fngRXfiyDk1IVdB0a/ZdWebKzWn/q49s3NodsqVn1pK4e4ZCnHxZLFAEAVDfnu7Pcc7jBp8SgdXSKEQ5ze+u/nmwekXrI37ZnReVM+Axb9+LGUgVCahr2p7B0z6iDQs5LBj0QqGPTO2pwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eDZnm2MS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eDZnm2MS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0lL7SuiPgUfyiSheen74q8JqInT1gIRp7Z1Ky9LkvS4=;
	t=1745421457; x=1746631057; b=eDZnm2MSlpvUCcyDhOUZ74kWUJ/5YVJtg4PPvM2N5vJQsC6
	ZULfSrXFv/ApcZJHhCkHe5afnD5gIj9Tv3nHLo08NXLZ1JnAaDlmsUA6WmOSto1cBQzFiY6E6U2Jk
	j1jSk6dx+HPG3WKB86VL002dXz51NZ0pKjHg2M79zfzFXpYXSD/einBpr70j//w/v371AWvHJmhQ2
	suLlK9XGwvSGckxEfE1CPyauO7KfQfweDC1SWbJwx9pUdMBOrJYfl+jroNulooGWOcBkGHxJFyji1
	HxfNWquJQHFMvVN1ry9Zj3XEtN/XjEo1SbCjygLx6yT6G4TV99ChkIvSMH0I46Fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1u7bqu-0000000EmZ9-2uns;
	Wed, 23 Apr 2025 17:17:32 +0200
Message-ID: <db0f8ec385762e6edb3edf5054a76ea189135e6e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 15/28] module: Use RCU in all users of
 __module_text_address().
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	johannes@sipsolutions.net
Cc: Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>,  "Paul E . McKenney"	 <paulmck@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Petr Pavlu	 <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Thomas Gleixner	 <tglx@linutronix.de>
Date: Wed, 23 Apr 2025 17:17:31 +0200
In-Reply-To: <20250108090457.512198-16-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
	 <20250108090457.512198-16-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2025-01-08 at 10:04 +0100, Sebastian Andrzej Siewior wrote:
> __module_text_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
>=20
> Replace the preempt_disable() section around __module_text_address()
> with RCU.

Unfortunately, this patch causes a performance regression for us. The
trouble is that we enable kmemleak and run trace-cmd so a lot of stack
traces need to be collected. Obviously, we also have lockdep enabled.

Now, combine this with the UML stack dumping code calling into
__kernel_text_address a lot[1] and it really has a relevant performance
impact. I saw the kernel spending 40% of its own CPU time just on the
lock in is_module_text_address.

Maybe kernel_text_address should leave the RCU handling to the caller
and assume that the RCU read lock is already taken?

Benjamin

[1] The UM arch dump_stack function reads every "unsigned long" on the
stack and tests it using __kernel_text_address.

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> =C2=A0kernel/module/main.c | 16 +++++-----------
> =C2=A01 file changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 80877741ac7e5..6a99076146cbc 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -823,13 +823,12 @@ void symbol_put_addr(void *addr)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Even though we hold a reference on the module; we still
> need to
> -	 * disable preemption in order to safely traverse the data
> structure.
> +	 * RCU read section in order to safely traverse the data
> structure.
> =C2=A0	 */
> -	preempt_disable();
> +	guard(rcu)();
> =C2=A0	modaddr =3D __module_text_address(a);
> =C2=A0	BUG_ON(!modaddr);
> =C2=A0	module_put(modaddr);
> -	preempt_enable();
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(symbol_put_addr);
> =C2=A0
> @@ -3694,20 +3693,15 @@ struct module *__module_address(unsigned long
> addr)
> =C2=A0 */
> =C2=A0bool is_module_text_address(unsigned long addr)
> =C2=A0{
> -	bool ret;
> -
> -	preempt_disable();
> -	ret =3D __module_text_address(addr) !=3D NULL;
> -	preempt_enable();
> -
> -	return ret;
> +	guard(rcu)();
> +	return __module_text_address(addr) !=3D NULL;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * __module_text_address() - get the module whose code contains an
> address.
> =C2=A0 * @addr: the address.
> =C2=A0 *
> - * Must be called with preempt disabled or module mutex held so that
> + * Must be called within RCU read section or module mutex held so
> that
> =C2=A0 * module doesn't get freed during this.
> =C2=A0 */
> =C2=A0struct module *__module_text_address(unsigned long addr)

