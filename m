Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE51AC89C;
	Wed, 11 Sep 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078706; cv=none; b=p9c4zv6ka4FGwzx7L5Tj+6zglLiTRiWJTnVgG674W8KKCZwDUHUQMTNcDLLTt5teQiWkYsM4QA4995o0YHZt0ODsuwQaOBeHwdrtM2YVuBk4Ulwga/5MGfgdTHxWJst9GP/Z4EW4oVZcAif/wk1zOstWOwdtF3mePkg7kxe7z0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078706; c=relaxed/simple;
	bh=HGCD1cOq1Br54GxXXCh+0fpSRE29y419lG6xkZ/Q9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X54lNxtjlcUL2ByJOk2OlKTiUpkMbfH4NkKrffTaWi0VNe6+miN7o8Wt7QgT8/Pg7pzbxSK8tRTpjuHat/J8MTMCYGSsPZXJjlq5maI52ii+N58pHn3DWV053tm/PCPK8V+Mbc/lqcUpqUZOhFN+Ohij15UaYA6jJmqk8//VGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUjlAjKE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUjlAjKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64013C4CEC0;
	Wed, 11 Sep 2024 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726078705;
	bh=HGCD1cOq1Br54GxXXCh+0fpSRE29y419lG6xkZ/Q9Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUjlAjKEQVBkMO4u2Sz5cspgQr5eOlx4fuYUSp0eRLkGPheftjp6iZInJu72BdZwh
	 p+EFdw/N1XHIJGqKMX8XAdLUjnm1Jjn7MyZXArYeYZ2GpbVx0zWfcPIbSxAeg3brrA
	 EwZ4oq4FJtpc8liMgS6fzUScNMayDinY9JdHDJV3Bb2YJrUf38nwhUHLvpiv0kX5Lg
	 P56ubB7qBbvYrIB9lcJbj+vfQyqv9jWj4CWePvNKeHN57Kc5pm5mIcnSVplsyhVWg+
	 9Uy0dIBf/RjZzH4U3Su3c+6oA5/yXW2UmtRqBzh4Qjm1+s0HNsoaWseIcTxpiGr8hZ
	 8ifl16249UY9Q==
Date: Wed, 11 Sep 2024 11:18:23 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chunhui Li <chunhui.li@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	Petr Pavlu <petr.pavlu@suse.com>, kernel test robot <lkp@intel.com>,
	Xion Wang <xion.wang@mediatek.com>
Subject: Re: [PATCH v4 1/1] module: abort module loading when sysfs setup
 suffer errors
Message-ID: <ZuHe7zib3MiRn8l3@bombadil.infradead.org>
References: <20240911032802.22413-1-chunhui.li@mediatek.com>
 <20240911032802.22413-2-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911032802.22413-2-chunhui.li@mediatek.com>

On Wed, Sep 11, 2024 at 11:28:02AM +0800, Chunhui Li wrote:
> When insmod a kernel module, if fails in add_notes_attrs or
> add_sysfs_attrs such as memory allocation fail, mod_sysfs_setup
> will still return success, but we can't access user interface
> on android device.
> 
> Patch for make mod_sysfs_setup can check the error of
> add_notes_attrs and add_sysfs_attrs
> 
> Fixes: db939b519bea ("Module section offsets in /sys/module")
> Fixes: 6d76013381ed ("Add /sys/module/name/notes")
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409010016.3XIFSmRA-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202409072018.qfEzZbO7-lkp@intel.com/
> Signed-off-by: Xion Wang <xion.wang@mediatek.com>
> Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>

Applied and pushed! I modified the commit log slighlty to fix the commit
referelcen to the first issue with sections as that is part
linux history.git.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=3f7b0672086b97b2d7f322bdc289cbfa203f10ef

  Luis
