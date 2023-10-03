Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898230FA6
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 20:55:14 +0000 (UTC)
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7899B7
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VsokC94mBvQ6nxM480FMKXo3MHqvOeCzL1zXciGiHFs=; t=1696366510; x=1698958510; 
	b=eXWSmO4gh8bekINwMgIyIvIMrLx2qZn+yg/QV5dDFYfGEA3YGgIsjXSoWKJCBdpkdnpbrdY7Ine
	vdOtqqNCYPs2qoCaNuf7v3/xohZjLj9Ty5dlX55xvq+VlI+i3nXRubFgNvwl2w9MzHA2WU0V9uK8t
	UUpN+8VYMZVj/2nw/gwzVo/MZMKLLERyigzBQ+o+By1uC1IIVdNpv8wK6bJcUpa8y6Q0jZjKCga9c
	olO496tQDpQ4VV8qOz/WWYDYbsgYDROVZ4R7xfbSlhCa+HGR+GUaLCXfftCCHUSYy5dinjh9Vfv6n
	6zxCnWjn08Gr9de6pjK124iXbUtRreU2DFQg==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VsokC94mBvQ6nxM480FMKXo3MHqvOeCzL1zXciGiHFs=; t=1696366510; x=1698958510; 
	b=927t0ZpNBdbUvL5mii4kaTphZ940u2JdHEdQCpuAMkJnQJN/s+ar8B9bQcXX8iBw8WNmcQLw2+S
	LVF6FXsjDDg==;
Message-ID: <acf37f00-cea3-4f77-9c05-3c0301221d2a@moonlit-rail.com>
Date: Tue, 3 Oct 2023 16:55:10 -0400
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
To: linux-modules@vger.kernel.org
Subject: Unbootable system with kmod-31
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ Resend due to HTML not making it through ]

Hello Lucas, et al,

I upgraded from kmod-30 to kmod-31, and could not boot due to an
inability to load any module.  Any invocation of insmod bombs with,
"decompression failed with status 6".  I strace'd the issue to the
call to finit_module().  In kmod 30, the call to init_module()
works fine.

All modules are xz-compressed, for which support is present in the
kernel (using mainline kernel 6.5 here).

     CONFIG_HAVE_KERNEL_XZ=y
     CONFIG_KERNEL_XZ=y
     CONFIG_MODULE_COMPRESS_XZ=y
     CONFIG_FW_LOADER_COMPRESS_XZ=y
     CONFIG_XZ_DEC=y

However, on a whim, I tried "make nconfig", searched for any
kernel config options containing "XZ", and at the top of the list:

     # CONFIG_DECOMPRESS_XZ is not set

That appears to be an automatically-set option triggered by the
presence of initrd; but:

     # CONFIG_BLK_DEV_INITRD is not set

I don't know if (de)compression on an initrd is related to same
on a module, but it was the only thing I could find where XZ was
not =Y.

Kris

