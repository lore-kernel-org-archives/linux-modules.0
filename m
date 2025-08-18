Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875130E846
	for <linux-modules@vger.kernel.org>; Mon, 18 Aug 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509692; cv=none; b=APpyX2IX0SDpbz1+cjRsxZkUNzsJ+CkBTYrpKQggJFgM1+5CbtJzMFf2T8aJsbo039Gq1cpO5jXMErMciK2axe2FwlWleIabWoNxtMBELvDF3E6NFDV/cMYdPLO93uoPB9iQdOJ5N8xZoLmo8qYUEbQMoBosQYEj3B04iKq2+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509692; c=relaxed/simple;
	bh=4OdodGdaRd8A2f6DGv3SVumNt7ax4g9b44X1lMxEw1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4RidFfnuxYBJX3bY9Q3giJ3YnMV1bbKEwvVxpsYpbbL5GS000wtt0SXeYELAeK9MLZb6AYuc1lyZ9cvtwLGEzm5VtGqSRvWTpa7MeuoIEODQmyjczj9uKzfZNVQj87g4jQ0pQIZi1Hp/Z5mM/7vcIu6YpFHQ0DJ6XpmNWUZ8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=SdQ9VgWu; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="SdQ9VgWu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QoV9JpaJwSF1L2rKSgoWP9PPxf44YZY4mICUkvuuUcQ=; b=SdQ9VgWuG+djZNVbKI8bZtLfrv
	s6esk7lGZW0ha8NKjGLfWG+txV0RYtxsbeimFy+PfyghuFUqke82ikHgkaU8lrpiZg+XnUoCvJl7w
	eQt586RQk0+Cm6qtMU1uzXd5Q4tjNg+vIixCXGAF9qPOF+I3MmrOopTE2gBY4qqidltjz3LD9nJjh
	PMq8TDj60q7d+pCt2nXpfQa8c8cnWi8rATIH07D5NTkMNdrB4RURPOHVMEDunvwV/Xl2AWo60uADe
	oyNCId3GraNGEzboGbuC08FdHy6zVnrNnpkkEUPGvgxGZZPytbCDanZEtU2v8hfz/gTvKtWpxus3N
	VDFRYHNw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1unwGG-000000007EV-3idR;
	Mon, 18 Aug 2025 11:34:40 +0200
Date: Mon, 18 Aug 2025 11:34:40 +0200
From: Phil Sutter <phil@nwl.cc>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-modules@vger.kernel.org, Yi Chen <yiche@redhat.com>
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
Message-ID: <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>

Hi Christophe,

On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
> Le 17/08/2025 à 01:33, Phil Sutter a écrit :
> > [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Hi,
> > 
> > I admittedly didn't fully analyze the cause, but on my system a call to:
> > 
> > # insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
> > 
> > fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
> > tcp'). A call to:
> > 
> > # modprobe nf_conntrack_ftp
> > 
> > though returns 0 even though module loading fails. Is there a bug in
> > modprobe error status handling?
> > 
> 
> Read the man page : https://linux.die.net/man/8/modprobe
> 
> In the man page I see:
> 
>             Normally, modprobe will succeed (and do nothing) if told to 
> insert a module which is already present or to remove a module which 
> isn't present.

This is not a case of already inserted module, it is not loaded before
the call to modprobe. It is the module_init callback
nf_conntrack_ftp_init() which returns -EEXIST it received from
nf_conntrack_helpers_register().

Can't user space distinguish the two causes of -EEXIST? Or in other
words, is use of -EEXIST in module_init callbacks problematic?

Cheers, Phil
