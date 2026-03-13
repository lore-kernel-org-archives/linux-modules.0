Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A83CB2E0
	for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422933; cv=none; b=oMg2dm2Ik/SY+nGHDod/SU1NUbsvN+R7TRJw28S5wcz897+jtcbONnbuIoQG4heDXCINIV92dL8lokUA5YehE73pZ1brPF90MsSWvHB39lXJM6bmEcxT3FFOAZxdAB9O+eHlzpCku6YukdgsdRc4rxO39Zh/ff3Yjow0qJCmp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422933; c=relaxed/simple;
	bh=WZm+qqdpH5DcyXRTP8NqNNo1VwwlDehNKpCHYen2rT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVPQAcid5g80YiRsnFexTG+MdwNH1VdpqJsU7jxG6o+tSuLg1En4nb1ctE8vzHmOGHqElkd2ccb0TFPt6I6lBnBH0XHPBouHELej9wZREjID5Cs99q2eZAlS+/pjteWvWn5llUnNcjAePqCMu6uKpr65r6HjsshSo7TM+NRxRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJ2h5VAw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJ2h5VAw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae49120e97so6055ad.0
        for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773422932; x=1774027732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KNoU1ZOyn2xMlV7RIm+49lvQ/6Dn6jFT+X4b8iUQRc=;
        b=pJ2h5VAwJiqVTdLZfAPuTsIH1AODm8YJp3r1Yj/+ZvkdPiRStaOdhTXY8Yign8INVd
         2Kvw0vtII6QocR217/HPfsh93xul7oy3a7lBQCyeDEnMbMPXVOyy06KHASCG7fcoqWUy
         TAsMw34WiMZawWPBL+L+Gw2C/lonL/REA47Rv77rYPjFB2sGW2xD+v71mxl503xaOOaI
         gyP2S8QtN3/pJHroKx705BhEiEq947CoAbmMugONWUQaA/tHgFFHMKpV93ckSbslFu0w
         hc5LUjLTccZTVjMuvi6BLaWso2GYSwaQTs6kf713uriF4rDb0l+W/R0uIzW9Iwa97WLn
         w0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773422932; x=1774027732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KNoU1ZOyn2xMlV7RIm+49lvQ/6Dn6jFT+X4b8iUQRc=;
        b=f0O9Euy/uH6k1pa59tb1gyQgpdyR4hbGTQqOsBWd9mJu1sNhoYnw5pr93YP1ssVHfA
         1D0CQbBHB20o9M7+c6uYjqx2dGXD3uqQuExiiSJdJ0pLxBJCI1/DfVXK0jw4z0t2v+SI
         E3OzCjBJwPdrcKsi7T8iQf3ol91PqYYDLz7+PjqNK2nw6dLUzddUze0ygIqylOYqxRO4
         LbGiDz6vNzqMz9YoHjpFNpi8aqdSLdcm3Tk53wWB7nvOANGgPMP2n/2fy12+0fOpm3z1
         iZ65i2C1yaIFJgSadyhG5c+moH1JmFMiFLE2o0mgA6pg7a7RXmT/9nyWI/2ALBMg9MbV
         yi8w==
X-Gm-Message-State: AOJu0YyQsdrTLC2gqN73OONqPReG80TZ1t8qeW6WFrSj2PVkepyvCIQh
	5oS1pfm8619XMx72v2z8FGGMWXSenPYJW71Knaz2pTXMLAONiVfLfzzcOVaptjkElw==
X-Gm-Gg: ATEYQzxZKo1ETm2juyTE0OOwiHNX7fEXNV7U8rEn6iO+CbmG1k0I8Mp/AAw4ftKUYTY
	WucYt0P78AuD4Y0On0CYCJ97i4U6T+5tXoqqd7+jHn3JJjqCiCSlNyln6QfrktIXSIb75nMM/Ba
	6C/jSGge2qQtZuy/+pTLpDTr9m/i3RmzEPkHTXbUbo4GyJyBfVGg9RCvXVDU0/Yx4OdOVjBILLP
	AsNc0WW1qNgS/Q0UN2PoGhJhxZop8Br89wizo0DdrorHXbAZe655/H5vQWWnK3OQhnMArD0VI6K
	4Ft7C08L2bixo0IINNTTudqEs9Xk89iSe6T9pv4Ic3NRKzs4aQTRi2PAzR7UxgWOrUFY/hBrHNm
	nDIVX7gwNz7dhuezg1dYwZNv/lHYJ989lPJ1bxWAZqlzKMkiRqkIQPNX+iKMd1unFU8z0o/vrQ7
	rX+PG+nxhAJnG/n8y4pfb6SNjvzZ7yTmtucI7ZSiM3rFJXF/vAl3KtB8iVkzrM6wxBWCk=
X-Received: by 2002:a17:903:2acd:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b0421fbe99mr66745ad.11.1773422931423;
        Fri, 13 Mar 2026 10:28:51 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072449fesm6928501b3a.13.2026.03.13.10.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:28:50 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:28:46 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <20260313172846.GD213695@google.com>
References: <2026031341-evolve-repeater-987b@gregkh>
 <2026031303-prelaunch-creation-3fce@gregkh>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031303-prelaunch-creation-3fce@gregkh>

On Fri, Mar 13, 2026 at 04:46:06PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 13, 2026 at 03:20:42PM +0100, Greg Kroah-Hartman wrote:
> > Module "versions" do not make sense as the kernel is built all at once,
> > the "version" is the overall kernel version number, so modules can not
> > really be described as having a unique version given that they rely on
> > the infrastructure of the whole kernel.
> > 
> > For now, just make this an "empty" define, to keep existing code
> > building properly as the tree is slowly purged of the use of this over
> > time.
> > 
> > This macro will be removed entirely in the future when there are no
> > in-tree users.
> > 
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Pavlu <petr.pavlu@suse.com>
> > Cc: Daniel Gomez <da.gomez@kernel.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Aaron Tomlin <atomlin@atomlin.com>
> > Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Thorsten Blum <thorsten.blum@linux.dev>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/module.h | 56 +++++++++---------------------------------
> >  kernel/params.c        | 30 ----------------------
> >  2 files changed, 11 insertions(+), 75 deletions(-)
> 
> 
> Sami just pointed out to me off-list that maybe I should also drop the
> srcversion stuff too.  I'll gladly do that too, does anyone know if
> anyone even uses that anymore?

Looks like a lof of distributions enable MODULE_SRCVERSION_ALL, but
I'm not sure if they actually depend on the feature:

https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=MODULE_SRCVERSION_ALL

Sami
