Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828840FDAA
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571914; cv=none; b=P/t9U1qT5RZndf6J98P/694VVhIQPydX5TC5ZLV4ZZ1xpky68EpNxogzl6Eo4zglVQWM1I4HC7AbDaWp2b9fzb5BDFe6t+Db4y7yjjbIV4OhOv764sno9RH8r9LJv+vVfslAoi6qE4rtNz8sA32ywpaJ/fY9VqTiMiavbYelBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571914; c=relaxed/simple;
	bh=8lnA9odFd1pYIzj2CFYw595M6YvPn7xJJHEbq9Qo0Xs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PMc9q8aGvesplwiw5W70hjAgS+ySKRjqkS682UqymloW0WiEEqi/VBBRXHC3KFNyyRLSAInuETc807pzNBSafQrTSUK5fO4/UTCzDjNDQvZ3iq95TwGUvwXLRbjp57DBOQvxjNLA/MjE9nIimgNyRZf6/7EP6tbRnc4HIF4tsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnPEftiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnPEftiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9AB1F00893;
	Thu,  4 Jun 2026 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780571912;
	bh=g1LBjyjsdB1BdhrZQLF4h3K00mTDsFLW4YkmFCz5jI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnPEftiPlcsVAsmCL2NcsFx6IJ9TmGcJKjXWbWWOpiboM5IKNJ2qQkmNhnkXhyMnn
	 xxGZbt2891BYZR7fAEStlwrQ9E3r4xuVDHvnDo/83UoCxEY4jjSYHEEZ5oCatBw358
	 g9ad0FOhRR0ZHkAeAUW1oQjzFiIGNJBCahVE9zl5g2hQKQm1NzJmb4gYA7enBDBEPv
	 lzFaZq2pt0If+/XPkdv8S3xULvsm5EdfpBfdG7GaOWN0gCC6pE2sbak4WOu+SEDiSG
	 JqIKfrBfYUmKxFXRpe1rvSMLhQQ6Cm3hUnMWGiMG3eQ7m59NLWcpuqG1WKcGWls0RR
	 0F+eNyM7RTyNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] xtensa/simdisk: Avoid referring to module::args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260604110455.1608038-2-petr.pavlu@suse.com>
References: <20260604110455.1608038-2-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 11:18:31 +0000
Message-Id: <20260604111832.3C9AB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent access to `dev->filename` in `proc_read_simdisk` and `s=
imdisk_detach` causes a Use-After-Free.
--

commit e0a519c0b452f39fc91f2ac38f46b81a32db738a
Author: Petr Pavlu <petr.pavlu@suse.com>

xtensa/simdisk: Avoid referring to module::args

This commit prepares for the removal of module::args by copying the filename
string provided as a parameter instead of storing a direct pointer when bui=
lt
as a loadable module. It also adds a free function to clean up these copied
strings upon module unload.

> diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/=
iss/simdisk.c
> index 7c7a2aa749f82..a2ddb49c269dc 100644
> --- a/arch/xtensa/platforms/iss/simdisk.c
> +++ b/arch/xtensa/platforms/iss/simdisk.c

[ ... ]

>  static const struct kernel_param_ops simdisk_param_ops_filename =3D {
>  	.set =3D simdisk_param_set_filename,
> +	.free =3D simdisk_param_free_filename,
>  };
> -module_param_cb(filename, &simdisk_param_ops_filename, &n_files, 0);
> +module_param_cb(filename, &simdisk_param_ops_filename, NULL, 0);
>  MODULE_PARM_DESC(filename, "Backing storage filename.");
> =20
>  static int simdisk_major =3D SIMDISK_MAJOR;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible to trigger a
use-after-free here due to concurrent access to dev->filename?

The procfs entry for simdisk devices is created with 0644 permissions, allo=
wing
any user to read it. In proc_read_simdisk(), dev->filename is fetched witho=
ut
acquiring dev->lock:

arch/xtensa/platforms/iss/simdisk.c:proc_read_simdisk() {
    ...
    const char *s =3D dev->filename;
    if (s) {
        ssize_t len =3D strlen(s);
        char *temp =3D kmalloc(len + 2, GFP_KERNEL);
    ...
}

If an administrator concurrently writes to the same procfs entry, it trigge=
rs
proc_write_simdisk() -> simdisk_detach(), which acquires dev->lock and frees
the filename:

arch/xtensa/platforms/iss/simdisk.c:simdisk_detach() {
    ...
    spin_lock(&dev->lock);
    ...
        } else {
            pr_info("SIMDISK: %s detached from %s\n",
                    dev->gd->disk_name, dev->filename);
            dev->fd =3D -1;
            kfree(dev->filename);
            dev->filename =3D NULL;
        }
    ...
}

If proc_read_simdisk() fetches the pointer right before simdisk_detach() fr=
ees
it, the subsequent strlen() and scnprintf() operations could dereference fr=
eed
memory. Does this need locking or RCU protection to prevent a potential oops
or local information leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604110455.1608=
038-1-petr.pavlu@suse.com?part=3D1
