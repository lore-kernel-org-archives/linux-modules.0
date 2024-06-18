Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C63210EC;
	Tue, 18 Jun 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740398; cv=none; b=PjjVoqZQ3svt9DhGa1Xu4kl+HUp7d43NiPHEfCq+zABPIr6v9/FifLj+Yx5DdJBEqO09DtKokwKaZBGXftnGBqXuy+E1FMNjB0qYdaEd+RZVIfqqS8NgxzXraocQBLtR5ImJyfRH0F8kQKfnAnO4/Hl2qETBKGzRKa9rN58njfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740398; c=relaxed/simple;
	bh=mjql8UVjFmjT3xbVPRryvjZExzCJC3cuiHDBPBi1ul8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfKsIZpGAOenPJoWsLWVMctmehSvh4Pf9Fyi/ZeR7/2mlB+WY/m2bufmUWk64+i1M2IyginM/E5H+EoRBbD706fyItepdvyG5G+zsawQ/UumTxDWrJoIBFuvtGL9P3k7xi7XYebdzuDeUNdun70JFdpK5PosubXiLC8OeL8ByPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FqyVbpr0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FqyVbpr0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IvC0ZqUdo7aejUp7mt3qN6gW71VaFywuAap8huW2vqc=; b=FqyVbpr0u8MEPQXq/Mnd5M3ndH
	h+67801DHoCaGPTfpA3ZakOUz96hjpy+IrW3StvFmzeqI7i6cclU7TZWF9evLDz8G5piNJW8eogmq
	6ta+ZEAV0J0VU256S65i7ArVeKEAXlwLH67JfWsFmq2mqQ3xaqRWpIxFfHu7NcXcmasyjvPglwelL
	8SDoGYCe3Dr2Tk2u1Q5BTh4d0qO2Qck9saEv0LKbC/WpqGDaU+MyK4tKwXp63nttJxVzfba4jDOg3
	LLXCAkQYn0wgvtOd1fjJRw855kL4v98bsqpFiOmTJNoDwRaNpK4u6BE94S9WuJPAZPo4QmS4IhW1V
	nbX9MhPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJetI-0000000GQAe-0il6;
	Tue, 18 Jun 2024 19:53:16 +0000
Date: Tue, 18 Jun 2024 12:53:16 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: create weak dependecies
Message-ID: <ZnHlrLI-XLkfhQBX@bombadil.infradead.org>
References: <20240510085726.327831-1-jtornosm@redhat.com>
 <4rfixlve7indkkudtsgyl7bfp5xykzlh3sf2xzlesjbo7xrh44@b4tdzwxxribv>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4rfixlve7indkkudtsgyl7bfp5xykzlh3sf2xzlesjbo7xrh44@b4tdzwxxribv>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, May 14, 2024 at 09:25:55AM -0500, Lucas De Marchi wrote:
> On Fri, May 10, 2024 at 10:57:22AM GMT, Jose Ignacio Tornos Martinez wrote:
> > It has been seen that for some network mac drivers (i.e. lan78xx) the
> > related module for the phy is loaded dynamically depending on the current
> > hardware. In this case, the associated phy is read using mdio bus and then
> > the associated phy module is loaded during runtime (kernel function
> > phy_request_driver_module). However, no software dependency is defined, so
> > the user tools will no be able to get this dependency. For example, if
> > dracut is used and the hardware is present, lan78xx will be included but no
> > phy module will be added, and in the next restart the device will not work
> > from boot because no related phy will be found during initramfs stage.
> > 
> > In order to solve this, we could define a normal 'pre' software dependency
> > in lan78xx module with all the possible phy modules (there may be some),
> > but proceeding in that way, all the possible phy modules would be loaded
> > while only one is necessary.
> > 
> > The idea is to create a new type of dependency, that we are going to call
> > 'weak' to be used only by the user tools that need to detect this situation.
> > In that way, for example, dracut could check the 'weak' dependency of the
> > modules involved in order to install these dependencies in initramfs too.
> > That is, for the commented lan78xx module, defining the 'weak' dependency
> > with the possible phy modules list, only the necessary phy would be loaded
> > on demand keeping the same behavior, but all the possible phy modules would
> > be available from initramfs.
> > 
> > The 'weak' dependency support has been included in kmod:
> > https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
> > But, take into account that this can only be used if depmod is new enough.
> > If it isn't, depmod will have the same behavior as always (keeping backward
> > compatibility) and the information for the 'weak' dependency will not be
> > provided.
> > 
> > Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> 
> 
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Thanks! Applied and pushed to modules-next.

  Luis
