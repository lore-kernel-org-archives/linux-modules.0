Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F420124B;
	Wed, 27 Nov 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733745; cv=none; b=KdC/PahCrZ5l67cEBOUr03nYgq8nR9mCG83RloIRxyBYyoZdRJTI1nU0wAaodaAY+vyflIeiKa5A3kWoC7Odk5nOfrCB2T8e5E27lGnwJAribrfCWo1MW/lWsuhB+oQdt4hTi7I1S2i2CHvA7ouPhph9s3whcrccPQ583WkdQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733745; c=relaxed/simple;
	bh=CfvF7GEo4vs03zbSWJV+/1/X2jHKiuqpvVQ5vyS7Hbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uspdFSP03PUj/qYVXFhtpdPD+LoZnWSg71Bexg0zU5A8S/NHORB4EQr5Pq1l99BMJrZvK1NeR1J/R+DaRgLWl7706ZSECbc8zp/nEt61WowphXTugQ7Xlm6q05AYPjad1M2eG7NdDk7S9fM7fmU5A7Zinavp9Fxh5HsZESHszrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYASBb5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYASBb5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F142CC4CECC;
	Wed, 27 Nov 2024 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732733745;
	bh=CfvF7GEo4vs03zbSWJV+/1/X2jHKiuqpvVQ5vyS7Hbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYASBb5dpCUDiWMT7GlmXTpSZFRDKFGXrr0sa67jKE8n82H69q8Iiki5cgYqyNyoC
	 qGJyB1MXM4vOpcnDXWXkbAch7zVwnUvH8P5dyfAWoIWU0K23fZOwjI+mXGpK0bfIA1
	 m52BillrZI/80NOL9lvo3MLXOOIeogOSaa++a1zAhEGifMpjOhS5FkUbBSsWZr6t0J
	 /ZyUNHTZ6NaPQt8UjVU4LHtebH2/DN35hVXUHQlyRJiGOjp91PELL7LHZsWTZUozNS
	 KEYQvOdwTebVTFSxXH2BgqU1HdBqsJg+cnnd1zWJ8dyo59BbugP33QXtp2Lze1CYqW
	 sexDcogsk/c9g==
Date: Wed, 27 Nov 2024 10:55:43 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/3] module: Split module_enable_rodata_ro()
Message-ID: <Z0drL3oXxkRWiNTs@bombadil.infradead.org>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <Z0YoSrSNCIcvHsBl@bombadil.infradead.org>
 <15637735-cb71-473b-8b8a-21a6d6c5059b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15637735-cb71-473b-8b8a-21a6d6c5059b@csgroup.eu>

On Wed, Nov 27, 2024 at 02:37:40PM +0100, Christophe Leroy wrote:
> 
> 
> Le 26/11/2024 à 20:58, Luis Chamberlain a écrit :
> > On Sat, Nov 09, 2024 at 11:35:35AM +0100, Christophe Leroy wrote:
> > > module_enable_rodata_ro() is called twice, once before module init
> > > to set rodata sections readonly and once after module init to set
> > > rodata_after_init section readonly.
> > > 
> > > The second time, only the rodata_after_init section needs to be
> > > set to read-only, no need to re-apply it to already set rodata.
> > > 
> > > Split module_enable_rodata_ro() in two.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > Didn't see a respin so this will have to be a post v6.13-rc1 fix.
> 
> Indeed I was waiting for v6.13-rc1 before sending the non RFC rebased
> version, but I can send it now if you prefer.
> 
> I expect it to spend a few days in linux-next before being applied to
> mainline.

No rush on my end, let's wait as you noted until v6.13-rc1 is out.

  Luis
