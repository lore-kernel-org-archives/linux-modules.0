Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139CA1FA84D;
	Wed, 13 Nov 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491791; cv=none; b=HMy3Lk2lPgevqq8P+35uC72VySU22mbgy7ZBSbmUSM4vUKRW0zrt1/NOpVvn1bfaDbQOp+lpga/GUKwmfkhSCwkD62/ZRsubdr3/92xvOfW4IRvxmlMK1DWE5ZZDt8LnbmnFMdeCHwnBWio3c58Y1+SevLrvIr9Qt6ls3/TogkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491791; c=relaxed/simple;
	bh=bvx8jAcX/A6fZXCDUJE05Wfh/AAiBpU4qvm1jooy1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8I32E7CtVkPiB2qiYg9qcOGpRHOHl+k73fRI4Vt8qnZEsR2lgjlo3oy5Mwwq3ZsZYoGeGiQvsiyfpUD6Aziz8zVaLHV/pflW1Aw+UNF0fq6qyyQmcVNoDQiVSz1lXzrf44dne7RT5+TAbiMers0G6GF/AxGSVq9hVdHYchhBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7x0/6xI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7x0/6xI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC5C4CED0;
	Wed, 13 Nov 2024 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731491790;
	bh=bvx8jAcX/A6fZXCDUJE05Wfh/AAiBpU4qvm1jooy1E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7x0/6xIKMp6G4IfpEco4TyZMuxyONQeQ7Wkn3OERHbdcdW1Vln4bMxBh0encVtSE
	 TgfjRxKtemHVXre0/gVws8b5Vil/5a2Hx6CkSYaSUBjTDzu8AtIKDSNYGpOOdT1jfD
	 NTq4orBTdQMJv8g853vrmEGOSamTCOIaXT1gmmbEqTadJGtT0IUJGOS5AMdYNPGYZ2
	 xcZ+7YBEd8gMXkUAzx9DoOUxPHoYLfzJnldgtjNAIpPtp+8G1q+cxJHYZog0jmOXCF
	 uTxk71dGz4SNuZe9v7zs85rSTmmaY7YFNsOM7IO31j2yS9JfQjUR4uBWw8/wgHGSfl
	 S3Y15DCVHvO4A==
Date: Wed, 13 Nov 2024 01:56:29 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/3] module: pre-test setting ro_after_init data
 read-only
Message-ID: <ZzR3zWzO2AoeiF8P@bombadil.infradead.org>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>
 <ZzO6cNo2MalF92OV@bombadil.infradead.org>
 <fa0f038e-3066-49de-bcab-97a779735665@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa0f038e-3066-49de-bcab-97a779735665@csgroup.eu>

On Wed, Nov 13, 2024 at 07:49:24AM +0100, Christophe Leroy wrote:
> 
> 
> Le 12/11/2024 à 21:28, Luis Chamberlain a écrit :
> > On Sat, Nov 09, 2024 at 11:35:37AM +0100, Christophe Leroy wrote:
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 1bf4b0db291b..b603c9647e73 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -2582,7 +2582,7 @@ static noinline int do_init_module(struct module *mod)
> > >   	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
> > >   #endif
> > >   	ret = module_enable_rodata_ro_after_init(mod);
> > > -	if (ret)
> > > +	if (WARN_ON_ONCE(ret))
> > 
> > Do we want panic on warn systems to crash with this?
> > 
> 
> I would say yes, for two reasons:
> 1/ It should never happen
> 2/ Such systems care about security and don't want vulnerable systems

OK thanks for thinking about this.

I think making this clear in the commit log would help as people these
days scream at random WARN_ON_ONCE() sprinkles.

  Luis
