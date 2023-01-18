Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7DC38142
	for <linux-modules@archiver.kernel.org>; Wed, 18 Jan 2023 00:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjARA50 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 17 Jan 2023 19:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARA5E (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 17 Jan 2023 19:57:04 -0500
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 16:44:02 PST
Received: from esa.hc4604-54.iphmx.com (esa.hc4604-54.iphmx.com [207.54.93.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C18577CA
        for <linux-modules@vger.kernel.org>; Tue, 17 Jan 2023 16:44:02 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2FbAABTP8djAIqlh5YNSgMdAQEBAQkBEgEFBQFACYE1B?=
 =?us-ascii?q?QELAYMzgViET5BxLp8+BgkBAQEPNQ8EAQEDBIN/gQCFGyY3Bg4BAhkBAQEFA?=
 =?us-ascii?q?QEBAQEBBgIBAQEBAgwBOlKFLzmCRSJ9gQgBAQEBAQEBAQEBAQEBAQEBAQEBF?=
 =?us-ascii?q?gIUUoEaDwEFTycCHwQDAhgwJAYCAQEXgmMBgzWhBgGKIHqBMoEBn0MJgXQFg?=
 =?us-ascii?q?Q8sAZABgR9Dgg2BPA+CBTgHhVMmgxGCZwSZbGyBO3yBJw6BSIEtJQQOAxkrH?=
 =?us-ascii?q?UACAQttCj8BNQkNSisTBxsHgQkqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJA?=
 =?us-ascii?q?gMiZgMDBCgtCT8HJiQ8B1Y3BgIPHzcGAwkDAiFOWhYCLhETBQMLFSpHBAg2B?=
 =?us-ascii?q?QZSEgIIDxIPLEMOQiEWNBMGeQ0LDhEDUDiBFgSCFlecM4EvUIEbEywXcwdtS?=
 =?us-ascii?q?pJfEZBli0OSToE2g3oFi1WUeQYPBC6DeaUxl0uCTIsAlRImhQiBeIIAMxoIH?=
 =?us-ascii?q?RODIglJKI4nMIQlihRVAjYDAgcBCgEBAwmLRV4BAQ?=
IronPort-PHdr: A9a23:0kD7oRGdgFEE2M6PlXxqYZ1Gf5xMhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k30RmQBdqQsa4MotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQVFiCCgbb9uL
 hi6ohvdu8YLioZ+N6g9zQfErXRPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q
 6VAADspL2466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUjms8
 6tnVBnlgzoBOjUk8m/Yl9ZwgbpYrhyvqBNwzZDaboGIOvp5YqzTcsgXRXZCU8tLSyBNHo2xY
 okJAuEcPehYtY79p14WoBagBQmjHuXvxSJMhnDox60xzvkvEQbd0wM+G9ICqWnarNLvNKgMV
 +C1167IzTPeZP5RxTj96JLHchY8rvGIQ71wa9HcyUYxGAPDiVWQrJLqMymP2eQXsmia7u1gV
 eS1hGI9tQ5+vyWvy94qh4LUiY0b1krK+j9lwIYpO9K4Ukh7bMakHZZUqSyWKZV7Tt4hTm12p
 io3y70ItIK/cSUJy5kq2gDSZ+CZfoSW/B7uSeKcLDl3iX9qer+zmRm//Eeix+P8UMS/zVhEr
 i1AktbWt3AN0QTe5dKdSvt8/0ah3jCP2BrJ5u5aPE80iKzWIIMizL4ojpcfrETOEjPslEnrg
 qKbdl8o9vWp5unneLnqu5GROoxyhwrjKKohgNa/Dv49MgUWWmib/vmz26P78E3iRbVKkuU2k
 q7EsJDGPcgbprC2AwtS0os77xmzEiuq3M4FkXQJL19JYhCKgovzN13TJP31AvGwj0ytkDdt2
 f/GIqXsDojNI3TfirvtYLhw5k5GxAYuzN1S54hYBqwPLf/wQkPxscbXDh49Mwy62ebnD9B92
 5sCVmKPGKCZNr7dsVuW6eI1OOSMa5EauDD6K/gg+fHil2U2mUUcfaio2psXbmq3Eu54LEqEf
 HrgmtEBHnwSsQokUOPqkEGCUSJUZ3uqQq4w/is7B56+DYffWoCth6SM3CO6Hp1Qe2BHBUmAE
 XLvd4qZRvcMbDydItR6nzwaWriuVZUh2QuttADk0bpnKPTb+ikCuZLkzth16L6bqRZn8T1yE
 tTY1maBUmV5hUsWSDIsmqNyu0pwzhGEy6crreZfEIl45/pPXgM3L9bnyOZ3D5XJXRjMeMyOT
 h7ySdWvBz01Q8gZzNIIZENwXdy4jwLE2SPsDrMIwe/YTKco+77RiiCib/12zGzLgfFJsg==
IronPort-Data: A9a23:OVpb2ajxSPkNJB6W+EPSI/4fX161aRAKZh0ujC45NGQN5FlHY01je
 htvWWzUPvuLNmXzKdgkYNi/8B9TsJ6Ex4QxHQJpqi81QS0W8JqUDtmwEBzMMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpAFc+E0/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WxwUmAWP6gR5weHziZNVvrzGInoR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw60c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDm2SCfItGvn9IBDJyCAWlvVbD09NqbDkl/q
 McWKj8yUyynitKomZW9esMwup4KeZyD0IM34hmMzBnqVK5gGMuTBfqao4YJgAJYasJmRKuGI
 ZNCNHw2MkmGOkYfUrsUIMtWcOOAjXn2dTFcpUi9qqcx5G3eigVr0arqNtOTd9CXLSlQth/J+
 z6fpTuhXnn2MvTciiap6WiOr9XVhA31RokQFeO0/edT1Qj7Kms7VkJODgHryRWjsWa6WtRCO
 wkR/SYzqaUp3FKkQ8O7XBCipnOA+BkGVLJt//YSsVrdj/OKvkPAXTVBF2MZLtA3ssYzRDds3
 0WIjdTvDHpivKD9pW+hGqm8nG6JNyoaElI+QSI0U1Ii5enJ/L1pp0eaJjp8K5JZnuEZCBmpn
 W/R/XJk3+pD5SIY//7hpw2f2FpAsrCMF1dtt1mKBgpJ+ysjPOaYi5qUBU83BBqqBLqERUKGu
 hDocODOsb9XXPlheMGJKdjh/Y1FBN7cblUweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPu8QCbCPwMfcqONrZ5yEWIU7IToSNuhf8MoMmX3SNXFXvENxGPBLBgjix+KTSufhiY
 v93jvpA/V5EVvw8lmreqxY1zLkq2C0k3mLPVNj8wVyuy7uMY3icIYrpw3PSBt3VGJis/ViFm
 +uzwuPPkk0HOAEISniIqtV7wJFjBSFTOK0aXOQNKbLYclE3QDF/YxITqJt4E7FYc21uvr+g1
 hmAtoVwkjITWVWvxd22V01e
IronPort-HdrOrdr: A9a23:KyvTbaHecEKX4ENgpLqE/ceALOsnbusQ8zAXPjNKKCC9Ffbo8v
 xG/c5rtyMc5wx6ZJhNo7690cq7LE80l6Qf3WDAB8bAYOCOggLBEGgI1+vfKlPbdBEWutQw6Z
 td
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,224,1669100400"; 
   d="scan'208";a="195412704"
Received: from 138-165-135-150.dynamic.arizona.edu (HELO [10.138.78.194]) ([150.135.165.138])
  by esa1.hc4604-54.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 17:42:41 -0700
Message-ID: <0f95a92e-d898-562e-06d9-8e0456062e36@genome.arizona.edu>
Date:   Tue, 17 Jan 2023 17:42:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
To:     linux-modules@vger.kernel.org
From:   Chandler Sobel-Sorenson <chandler@genome.arizona.edu>
Content-Language: en-US
Subject: When adding a module, what does "Exec format error" / "Skipping
 invalid relocation target" mean, and how to fix it?
Organization: Arizona Genomics Institute
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I'm trying to update some drivers.  After uninstalling the old drivers, removing the modules, and installing the new drivers, the new modules are unable to be added.

For example:

# make -j16 install
[...]
make -C /lib/modules/4.19.0-5-amd64/build M=/usr/local/src/QAT.L.4.20.0-00001/quickassist/qat INSTALL_MOD_DIR=updates modules_install
make[3]: Entering directory '/usr/src/linux-headers-4.19.0-5-amd64'
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_200xx/qat_200xx.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_200xxvf/qat_200xxvf.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_c3xxx/qat_c3xxx.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_c3xxxvf/qat_c3xxxvf.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_c4xxx/qat_c4xxx.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_c4xxxvf/qat_c4xxxvf.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_c62x/qat_c62x.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_c62xvf/qat_c62xvf.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_common/intel_qat.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_d15xx/qat_d15xx.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_d15xxvf/qat_d15xxvf.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_dh895xcc/qat_dh895xcc.ko
   INSTALL /usr/local/src/QAT.L.4.20.0-00001/quickassist/qat/drivers/crypto/qat/qat_dh895xccvf/qat_dh895xccvf.ko
   DEPMOD  4.19.0-5-amd64
Warning: modules_install: missing 'System.map' file. Skipping depmod.
make[3]: Leaving directory '/usr/src/linux-headers-4.19.0-5-amd64'
make[2]: Leaving directory '/usr/local/src/QAT.L.4.20.0-00001/quickassist/qat'
Creating startup and kill scripts
Copying libqat_s.so to /usr/local/lib
Copying libusdm_drv_s.so to /usr/local/lib
Copying usdm module to system drivers
Group qat already exists.
Creating udev rules
Creating module.dep file for QAT released kernel object
This will take a few moments
Created symlink /etc/systemd/system/multi-user.target.wants/qat.service → /lib/systemd/system/qat.service.
Starting QAT service
modprobe: ERROR: could not insert 'qat_c62x': Exec format error
modprobe: ERROR: could not insert 'usdm_drv': Exec format error
modprobe: ERROR: could not insert 'qat_api': Exec format error
Restarting all devices.
Can not open /dev/qat_adf_ctl
Checking status of all devices.
Can not open /dev/qat_adf_ctl
     *** Error:usdm_drv module not installed ***
     *** Error:qat_api module not installed ***
     *** Error:qat_c62x module not installed ***
Can not open /dev/qat_adf_ctl
make[1]: Nothing to be done for 'install-data-am'.
make[1]: Leaving directory '/usr/local/src/QAT.L.4.20.0-00001'

# modprobe -v qat_c62x
insmod /lib/modules/4.19.0-5-amd64/updates/drivers/crypto/qat/qat_common/intel_qat.ko
modprobe: ERROR: could not insert 'qat_c62x': Exec format error

# modprobe -v intel_qat
insmod /lib/modules/4.19.0-5-amd64/updates/drivers/crypto/qat/qat_common/intel_qat.ko
modprobe: ERROR: could not insert 'intel_qat': Exec format error

#

Meanwhile, the system log shows:

<date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 000000005c09d38d, val ffffffffc09ba2fe
<date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 00000000690eef73, val ffffffffc0b572fe
<date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 000000007d30ad16, val ffffffffc0c862fe
<date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 00000000671d2da7, val ffffffffc0cd82fe
<date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 0000000072877855, val ffffffffc0d2a2fe

What are these errors even talking about, what is the cause, and possible solutions?

Thanks so much!


-- 
The University of Arizona block 'A' logo.
	*Chandler Sobel-Sorenson*
Systems Administrator, Senior
Arizona Genomics Institute
School of Plant Sciences, Research
THE UNIVERSITY OF ARIZONA

Thomas W. Keating Bioresearch Bldg. | Rm. 200A24
1657 E. Helen St. | Tucson, AZ 85721
Office: 520-626-9589 | Cell: 520-907-4352

chandler@genome.arizona.edu <mailto: chandler@genome.arizona.edu>
Pronouns: he/him/his
*www.genome.arizona.edu* <https://www.genome.arizona.edu/>

	Integrity, Compassion, Exploration, Adaptation, Inclusion, Determination <https://brand.arizona.edu/signature>


