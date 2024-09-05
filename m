Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB3194AD6;
	Thu,  5 Sep 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529291; cv=none; b=Q9frjukgxboM+wVDnpAqRgO7mE14RKq2h8cYxAZiRK7uyrBVXUvb/M+ai0nfOZxHVXCiVrR+VeW+choPTQBZ60mT+B3+UT3pMjwv6h3RlsRAVCn88lCI5TqauYivr+1o3GBZr9l5dORhhZ0N2NXWgKkSWaixRWiwNvX3nXK32wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529291; c=relaxed/simple;
	bh=pFxBIbHMWlurhJCO/FoxoV+7YJkLtC8xxcPcrbWbijQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sba5lRN0i7993LIdBHs1KqfRmqumQh76dVjGmJnKioqy9BqFxYINb8Hk+sgv19Yu5IhogpS7G9A9W7wD8LVVWPJaewRIv4ocCS4hgEX2KKtv/yJK81Xr5P9RekobAv8w6I9m4QdXfoW72nHnDvFrl90kfSOOvC11olfYXisixA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fsBPUKAj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsBPUKAj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dYxgkAANBViVPNy8ClXjafqQATE1JazRDJbttnPzMRI=; b=fsBPUKAjwTopifxfTgSbOdzpXt
	LIGVaN0ii3W2T/ZMXK0xt6RkuF0iK86k7dTlqnCLxBmac9/CByV27fRqEObZV2bVwsWUt0b8wKL+z
	D4bw3/U8jOPYyDIC7aR8/iBOm6ARKDOESi2MCjVu+Qnttan7H8WnMGse+25E633D3BwIH3xlT4/gP
	IjciF+sX3trFc2rtbSakfSidVwnD56kW/YFKYl9Ix+ROsmXsyyAL6XHefuWQbbDHOZqPzpEVR0AS/
	wicJTXLgN5+K/BftoX7cEUIxKdSdnfsZZ1nduzT7KHjLyexLHZin+FMrjEnyFWYcixUu1RQaqvZTo
	sjfOUx4Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm8zZ-00000007oLm-0nnd;
	Thu, 05 Sep 2024 09:41:29 +0000
Date: Thu, 5 Sep 2024 02:41:29 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chunhui Li <chunhui.li@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	kernel test robot <lkp@intel.com>,
	Xion Wang <xion.wang@mediatek.com>
Subject: Re: [PATCH v2] module: abort module loading when sysfs setup suffer
 errors
Message-ID: <Ztl8yWZMhjSExF4L@bombadil.infradead.org>
References: <20240904124108.20444-1-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904124108.20444-1-chunhui.li@mediatek.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Sep 04, 2024 at 08:41:07PM +0800, Chunhui Li wrote:
> When insmod a kernel module, if fails in add_notes_attrs or
> add_sysfs_attrs such as memory allocation fail, mod_sysfs_setup
> will still return success, but we can't access user interface
> on android device.
> 
> Patch for make mod_sysfs_setup can check the error of
> add_notes_attrs and add_sysfs_attrs.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409010016.3XIFSmRA-lkp@intel.com/
> Signed-off-by: Xion Wang <xion.wang@mediatek.com>
> Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>

Please use Fixes tag and resend.
 
  Luis
