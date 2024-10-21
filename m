Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F11E47C5;
	Mon, 21 Oct 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542061; cv=none; b=QnRQF9Zg+kMMr6wShJ+JC4I0M/Av54xn2ygIKvXR7VbmXSc9rxeRdhBvDyY6FWZY7aPh3rysruXdZ0b3HsWHd/Ws9U9oJEoxNQbrvpqIj8N2U/d9SD2oHPw9noVVUfz/z3BbmQwArz3n/xpC3hdTAYZgfAzTYCpuLg0QEmyBFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542061; c=relaxed/simple;
	bh=m4oqr2tD/s2q9iXgwqX/ld3yz1c3aRHuUzAprtVqFro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3aWOe7J8MUHgzsBuX49r8f8ZnuLXStVPKcVfeBqo+Uj9YT12Gz3CgXBrxKbDnp3mksxGOvBSzPVM/qTVC8J0lvZu/MTNZMOpQy7JHW35zzYvlpTVKHKPfkLLDpXva1zzqOIiCte4bxIYb9meHsHdBiXCbbqBfb/8vuYzSjjL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org; spf=pass smtp.mailfrom=stoeckmann.org; dkim=pass (2048-bit key) header.d=stoeckmann.org header.i=tobias@stoeckmann.org header.b=vaph/RmE; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stoeckmann.org header.i=tobias@stoeckmann.org header.b="vaph/RmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stoeckmann.org;
	s=s1-ionos; t=1729542041; x=1730146841; i=tobias@stoeckmann.org;
	bh=m4oqr2tD/s2q9iXgwqX/ld3yz1c3aRHuUzAprtVqFro=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vaph/RmE0+AXsLASUpOEAfVMM2QyF/rTE2qpBTaUzdWso00FabmWb9XDAk1C8WsL
	 bMPomGioZY7pumPp01TFKKtkDRI+ZeaGfyvjKm3g191aBg0UVxbhSwHsFOIusFWTg
	 +De2d+k8FLhdqAYGWaGr5GhaV4v43c2PhuKB02pIBmvh5+2bjgDyYaMe+GC1gzepF
	 j6vkz1PhArb/NJwaoyYcR8A4hh/LNp6tBcIVY2YF9roBUSVcIaKPfV7ENHyUoSLKa
	 1drKXj8MWIXUSGzXXQN9ohNoGEE0pSizHbXLhr7tqBV6N12o23u3WqqDbeZze+ieR
	 acJDKOH8YK9zsCxP9Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.225.54.107]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3Eqr-1t4MKr3FOP-006RlO; Mon, 21 Oct 2024 22:20:40 +0200
Date: Mon, 21 Oct 2024 22:20:38 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: check symbol name offsets
Message-ID: <xq5kctkuanhzziv6cizkq5e3xgoxdnzzqft3wwu3kc7djgguem@l6kmhhd72lxr>
References: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>
 <ZxaxtnuAMuuTgN2I@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxaxtnuAMuuTgN2I@bombadil.infradead.org>
X-Provags-ID: V03:K1:te7wBQEnN4qPti1Nes7lN9pNh6+HfAzWLk9mifBSwioSPlom4i6
 oRP9vGYZ5aZL6r/kZbOgh8k9bO8VTK4kNYkynLaCB7kFnE0226Bwa/yEWNXXgq0zrtF/22J
 PxgMrDCksv9TL+EwGb4HVpp4klo4gjn2vYUqSO0DxfGmaIsV9VWp0sMMMhk15wwmsRXrss8
 zt+VH63rxlhS5wAqRs6sQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x6/4dPtPBHI=;34dhw6T+b8nbLszruzRGK/DaBPa
 QTRBwkCcxR+mgS8KZDFPDu3vtSRbw51pupdsgBYJIJykrmfCWAI+O18AlwX3rBmrwn2sgyeP8
 BG60OZYJYkxIN6j6rj1t30BY6GtSPkTF2nsXRXxqpxAjxJJYnKGuLoH9cgYBEXlvNLQn2BnAo
 um4tdJtvrospzwgVLe45qTB9mX4Pjc03tYYU1Yu+g8ZvtDWuOLAnMAn/BewtYvMIUDgMB6aUj
 ntmAs5a4Bizgj9mOVizs0je1kbnMqxbsOM1Des9zgPTRXE0n74sOnUOH1UJjDW0en/t92qUpt
 Hg7wLP85dK4BNAtOmFdlUZNeA4b6DHfQ3ZVCuWlTxah5ToP8KvzhIuPFQ5PZ7cVcccWr1dV+f
 Z9YiIigiuJWUJlEz7lJl0quPLoVNlnGSGZYA6YLRAENTh0X6wEGX3csKpXaZM4XptxAM8Gknd
 CAkKANeSDEeLRBYKRzHb8J/3lEZopBiYIEJnG5VXzUymDt9PR1slGx3+6mZYl+QxEn3+XLzKt
 C1p1wuIiSMeVejGUlz9KJ4NVpTOf2xknoUy0vXVc9DettGPrAvZwNf08Qq9/srGUsYe6k/C7k
 TXN7a8HUgi3EOBDtq6YvGI9JBVWU45RPHdHtpmBbz+n9VieBt/I/Lh4yv4h5gP1sv48CufJim
 gZp3qij4++xwxtmELc5G8Dx2Zso9zvSAO0ztOhF711sfrdPRWObRoCvguLZGxBVuf/X+6KU9x
 NaqyUkoKqJNNpHP785qXjVSZW5E0cWDCw==

Hi Luis,

On Mon, Oct 21, 2024 at 12:55:34PM -0700, Luis Chamberlain wrote:
> And then you can make a series with 3 patches for this and your prior one,
> and you can just refer to the PoC in the fix.

Thanks for the hint to rebase on modules-next. There is no need for my
patches, because the checks have been written by Matthew Maurer, which
cover these cases.

So... Sorry for the noise and thanks to Matthew for writing them.
Clarifies that specs are correct and checks were missing. :)


With kind regards

Tobias
