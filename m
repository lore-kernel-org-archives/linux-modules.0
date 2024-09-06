Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F615AD83;
	Fri,  6 Sep 2024 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665168; cv=none; b=Y8gPmk635oA1qk9VEqweOOWbk5txCaBM0a2bfedbl2LluQWp4edhKX3ExN/1+yKTIn7KHbU2yZYLmvCXpS8N2PmyW0EkTKtQLNOTBm8l/0dGQ79KMe0tEMqMOLswgRGo7LYiTgWhMdBb54t7V2BHS3P4u3okpT4hC0/5K+injwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665168; c=relaxed/simple;
	bh=jXCm8ZMSU3z06aR8qQb3x6kAwRmsM1D0/BjVjdNv/fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE9RuQwtaELe+pX27OILWYptoDRQ/BNjeQY7V9EA9vXOVciiXI64tH/HdxbJo6hsBbg9YV1Zit/QHs5/2IfBndMKVYZHSPavqtyVXTCmV7S2jiG8rGC0jV2t3Bms4XpP+5qswDXfGtjXE/dyxnOmnCfUYcqv1gzdMuvPUSqT5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MCooQiq3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCooQiq3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9gOv4+PXHcISx1FgSRbSk44f968oeYy/3CMM+F4Cj6c=; b=MCooQiq3Jl/3zi0eJdz5opXJxe
	VOsTTovj+x0DFB5ZwNtxoJc7XDv4wHGZ7MBZbpRW6ymgUzGZn5SwM2D2+p5DApY68Qq48eDkVcH6Z
	OGWCZ0GdOgptoypXsaW44hmQfrpMciKhMqjDwKYP62r6ganNQzfwufL0mEroCwhTT2XRjyUfwHoiI
	c767HwlIJqpFBaOgWap6QVvAfp1LAQyfa9b1rA3Y8mql7GwyeVsxBpJxBqpjUWBmf3qTf7byQSKZ7
	wrByN95Q5SQfcIi7Cp2v5Yek+9iWgHqSejEvtPoPYp9rtQBduKA4OVQWSGO5Vn+BgVC05wXwpL1ob
	89sb0qXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smiL7-0000000DrSU-1yZR;
	Fri, 06 Sep 2024 23:26:05 +0000
Date: Fri, 6 Sep 2024 16:26:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chunhui Li <chunhui.li@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	Petr Pavlu <petr.pavlu@suse.com>, kernel test robot <lkp@intel.com>,
	Xion Wang <xion.wang@mediatek.com>
Subject: Re: [PATCH v3 1/1] module: abort module loading when sysfs setup
 suffer errors
Message-ID: <ZtuPjYaA54RmY279@bombadil.infradead.org>
References: <20240906115748.5367-1-chunhui.li@mediatek.com>
 <20240906115748.5367-2-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906115748.5367-2-chunhui.li@mediatek.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Sep 06, 2024 at 07:57:48PM +0800, Chunhui Li wrote:
> When insmod a kernel module, if fails in add_notes_attrs or
> add_sysfs_attrs such as memory allocation fail, mod_sysfs_setup
> will still return success, but we can't access user interface
> on android device.
> 
> Patch for make mod_sysfs_setup can check the error of
> add_notes_attrs and add_sysfs_attrs
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409010016.3XIFSmRA-lkp@intel.com/
> Signed-off-by: Xion Wang <xion.wang@mediatek.com>
> Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>

Please add a Fixes: tag.

  Luis
