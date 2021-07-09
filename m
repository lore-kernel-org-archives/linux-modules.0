Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B0BC07E9C
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2520613C7
	for <linux-modules@archiver.kernel.org>; Fri,  9 Jul 2021 22:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhGIW2n (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Jul 2021 18:28:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62210 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhGIW2m (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Jul 2021 18:28:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169MKoWv028043;
        Fri, 9 Jul 2021 22:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=qCqJJoG6lgH+4epSHWYtX3IJe21uNKOEx06ZWVkpZME=;
 b=KeFpV99tju7t2fr80HGPnN1lEDWe5uS4iJ253kkvNtUEs7CVLqKepXVl7BVImy4tbjqU
 LzufvMVpwzE42X6zQ2DyrpCa7lcWnUj8ZW9kkqkQ3/TkR+VbcuBM2RIs+1hDdJwI2T6C
 i/psWeUTms3NhHR7cRV6AZwOGMLTNzRvXhg3ZYsygNTNbi2sMYJTK+bEF/P3I/zJH3xq
 bBkAqvHU3uze3T+qDn22ltcFxt6qGO9UIO21JfnUzxLfDgbe79cG+EFz4z0sSYqsm2c2
 PQcCORmJlyx6CB7T5et3HQ/RnfGTc22HxgptNh2IhVvCOSr6IwUW4mWNFX82eP7Teezg 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pkn49cjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169MOmJn072128;
        Fri, 9 Jul 2021 22:25:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3020.oracle.com with ESMTP id 39k1p6quuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 22:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Orrj17V7VKwxtOm75ac9CEMpQVDBX2tsvPYWe7LTrqNxhDZIw9F97Y0enI/yRRJ07OoO5XSOq5AGrC0DclhHNYQ78d34n9XNLicphftWEBSt21+riC3IGZ0BXT3xjFn2owUHpj6hOoF+O9sp7+KmiWB1Sl+1AnlZe8soMCAIE+I4zXMOjUCcLndV7ZcJyE2FLSp8SUbB2tEiYkFGyJjo8jvftGWsNOr6oM8i34r2M9b10Q8zdo7Pi/h+6OV82DB1nwS9MS5KMUEJfQANxSTdDM8y1UgiiFAZcbknSHwhKYGxt/gJzCbfIJM4qe5Nv9aCukjwgD4z3YuZk6WC/25/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCqJJoG6lgH+4epSHWYtX3IJe21uNKOEx06ZWVkpZME=;
 b=gDRWeW5k63GwSuFfC2ozeAmV7sEv1N6PphsDJ02S6FJmQ1iLriFwXh/mqp/cQBL41wJVuDRxfFljBT0kyGyhpo/EwUCfQmD/eYVrNYs6qiztWRhXMGkXQEffs90+VitmLmRk483Vlrd3zbjq1DhyxFzxzsSK81r+qZvE7KetAtcmLXBfS0rZEGpF3GIdh1Lj1r+08VqeAeKIYFMDq+aUiZPSiXSNx0iH5BjJgSUhaxZhxRUpRy5YcfS2udEWRZiNc5u87z3pY2/ydDBKGwjjq2UdcEa2rVXXmYpIzNddQ+1rN+ShH7xSjl23xW6WZEsBH8kNULzwLZcqiRDQW2QmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCqJJoG6lgH+4epSHWYtX3IJe21uNKOEx06ZWVkpZME=;
 b=ASII6JURraiylJOikrod1M59dboKsCxTdoU8DtOjm0iKq5GEDDTS/x0/Yb9Pm9GqX4zxoHbnCoQfaJgIdoeHOCpdkC/Kq2Yc42Wpc1aXJ2uIpRDTZfOQgQ9f/tprmWYteXNs9dVfrd7HmD/yGfST8IEsO3yPrgEeMUOLwFW3ixw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2927.namprd10.prod.outlook.com (2603:10b6:805:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Fri, 9 Jul
 2021 22:25:50 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::956e:3ceb:9de9:8854%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 22:25:50 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, Eugene Loh <eugene.loh@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>
Subject: [PATCH v3] kallsyms: new /proc/kallmodsyms with builtin modules
Date:   Fri,  9 Jul 2021 23:25:16 +0100
Message-Id: <20210709222523.17639-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.32.0.255.gd9b1d14a2a
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 22:25:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87424a36-e038-4394-b2b3-08d9432881e7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2927:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB292702A550E6929AE30568B68B189@SN6PR10MB2927.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDmgkDQpaTujH2uOzrTzkE0CNhOzRhDU6ilSPHKJFcDMvKVhWnJAmJ0wEtPvtY5QytIdnwVZbBd1q9InwZ1OraMKVMahUKG1FX+cZJJ6jY1YGn8naez21YytKBsp0hkTxWi4F5IUGs34neBI8I4kb8rMsRj6tWGN4NjZtzv15X3kQIMRu0TUFUmM1QrVrrc+xq7Fysv1ERKRB3TPnwrNM7qRI/P8gmetPhTFsg/JMi5W3Z9gbvAaCxB9vOAlqFzmIH3DUD3uggCnhUzFhToPs1wg+GSYYOTt83BRs4+AQsHz8SUvT7IWecNoKe8GaJ4ZsaGdz0JJDcmCq49Li+ZNaBuGW2ib8CIqkB//LcsAyDheFSy6197PMRItZSiovWSnJFOEfWQkMB+Fp9KUnxFSX08oLwSKnsazXe/ue5yPPzascM12V71CgnBOk/2cfBj16yT+CR9rGBGZ+JhOVJBb8G2R0jp886OX+i/XWtf96cFKac7GQA/h4VcHnOXWPONcq1FUBTl+3z5BRel3e3OazpHhRoethZv8p7Bb+AKRLFC5UCAVnJse6vL8F8u92B3UKJgWs3wbTuB/Ev7/vgAMQ6KoeqvS4ZzaT4alwKf4+4CVNBQ29mr054NIJq5YrS2S1Gi6PODaCntDkTT8m8IOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(478600001)(66946007)(8936002)(66476007)(1076003)(44832011)(6666004)(107886003)(8676002)(83380400001)(2616005)(66556008)(6506007)(30864003)(86362001)(6486002)(2906002)(38100700002)(36756003)(5660300002)(4326008)(52116002)(54906003)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Ke/gLNiQr7X18SWtTIQzrci4PiYEMpE4N24s46zM5KpQFGk9+Tbli7qx1mD?=
 =?us-ascii?Q?uhEd8m+wtD0UD6i85E0WIBA6OpyZHeuMtoOzbZmwCIcHNtBkQYBu0XhDVAtI?=
 =?us-ascii?Q?/WBnnCMspa9BzBgNhx/UweGguBipKgtEaSYKtufkzxaHtRKdZokGLO0/mbEi?=
 =?us-ascii?Q?ZZocuUMRZQeXwQKYQ9hiKonhyAxMMr95hBvCh/Rx1ZdrxEkwdfXlj9QuuvHN?=
 =?us-ascii?Q?YODeIOwUVLvtQsFW+jSuJR+aBVyADFu5bWTGFgzt16yUejFUt02Soc4mLQLk?=
 =?us-ascii?Q?YTs4SWVKlsuvp+Kyoy09y92JwFltHL1w9d3XO42Ij0hTdlzl/UXgAuGSO4az?=
 =?us-ascii?Q?k/3Py3o2zmQSE7TQEPCIOboUtF8KdbbJ3OmETIGeaYiYcYwpXla7N6fn95cX?=
 =?us-ascii?Q?jn2L7UkSMgBK/FVD9ywxBZt85Y6QWfcrHmJn+xfMqdNqIZS6RlUa5hQosLJz?=
 =?us-ascii?Q?zxiyUkQiC2iHgErDHvo1kbqDUs2NK0L4nf/8Vv6X783v5/ygM8tWRD/W71E/?=
 =?us-ascii?Q?rivehEdVjIRmZegwWCAB19Gs3xOM9hKjQIYJ+y822PwIpK4VtjAlyRHHWX7Z?=
 =?us-ascii?Q?cTKX3wA2LfmJ/H6POfP+i18BaphCQyu/vO+NtbEOCNdomnBhX7YLf3jWo99p?=
 =?us-ascii?Q?PJpHcPwddUFnSkys4jegBdQPZMlzL7xn64yI5iNqYYbgVwaECyPelLRY8YgR?=
 =?us-ascii?Q?8/lSfkqz2QeJax1MONiBzSgNZXN/yOjdRbubxx4lZmX54+izQo5Uvbj2L6bn?=
 =?us-ascii?Q?wsvqvppwHWz1jVElV0xnB0zbhp+Df5mJN3OUfzwrx6qt0BK6zpKyBfjsdGcB?=
 =?us-ascii?Q?ITaIe1tSULv3kBBoDgXAfDM7GdSd9X349nv2YUFl7SwiLbmUcRpku4Zk2bbc?=
 =?us-ascii?Q?uql1Q3pMRbkCCfQgvbDfw3haZZC0LHslwMSkhHXITszMPY0IJ1x3j+HnXvU7?=
 =?us-ascii?Q?j0QPj+kGhDgkjjSzQyUC7VqzcquuuBnlb6QwCRcQ6H7Fdg+6dmk+xSN3+ka6?=
 =?us-ascii?Q?iT2yzwahttl/WG/JSwrZSvP8DtEXC2Q8u46fqIpwPmO09ZpBuZECXQrZz1r4?=
 =?us-ascii?Q?rs+E7CuBE5qKk343qIlZGntR1DSXMSjSNzL0NBm9ZN6Hhx2NMwfjP8k0DSNl?=
 =?us-ascii?Q?xnOhm0vcle6HaY+82lgpa0GcM0xLFtt8XD4sihz4E4mAlIlY+M+W5omJumgi?=
 =?us-ascii?Q?BV8nAwvjJWIH0a9EyX5DmoGNStJ9qybLBdoZ4cYyWCj8yOPHuApCdZDwkI2L?=
 =?us-ascii?Q?KqC9UO1qVhBz54VuhoHUGV2lpgYBy3BFoAQE86SB1nRR4i82DvByBaiib5Ac?=
 =?us-ascii?Q?Ysdin1rmJLL02dE7fEunUckyqms/k8sduQ5jPfrs367MkQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87424a36-e038-4394-b2b3-08d9432881e7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 22:25:50.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOZbQP01ZJ/41XxjQKXB8b0An/N1lXGJ1DU/jZCkB+ykSKsuq86fVqszhEXb/4ENH1SHFUKUs0XRnbYemqcQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2927
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10040 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090114
X-Proofpoint-GUID: HhvqvqIKqppuKnEgHlg8G1us0ThJYaTQ
X-Proofpoint-ORIG-GUID: HhvqvqIKqppuKnEgHlg8G1us0ThJYaTQ
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

/proc/kallsyms is very useful for tracers and other tools that need to
map kernel symbols to addresses.

It would be useful if there were a mapping between kernel symbol and module
name that only changed when the kernel source code is changed.  This mapping
should not change simply because a module becomes built into the kernel.

It might also be useful if there were reliable symbol size information to
determine whether an address is within a symbol or outside it, especially
given that there could be huge gaps between symbols.

Fix this by introducing a new config parameter CONFIG_KALLMODSYMS, which
does several things at once (introduced in distinct commits inthis series).

Generate a file "modules_thick.builtin" that maps from the thin archives
that make up built-in modules to their constituent object files.  (This
reintroduces the machinery that used to be used to generate
modules.builtin.  I am not wedded to this mechanism: if someone can
figure out a mechanism that does not require recursing over the entire
build tree, I'm happy to use it, but I suspect that no such mechanism
exists, since the only place the mapping from object file to module
exists is in the makefiles themselves. Regardless, this is fairly cheap,
adding less than a second to a typical hot-cache build of a large
enterprise kernel.  This is true even though it needs to be run
unconditionally whenever the .config changes.)

Generate a linker map ".tmp_vmlinux.map", converting it into
".tmp_vmlinux.ranges", mapping address ranges to object files.

Have scripts/kallsyms read these two new files to map symbol addresses
to built-in-module names and then write a mapping from object file
address to module name to the *.s output file.

The mapping consists of three new symbols:

 - kallsyms_module_addresses/kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as kallsyms_addresses/kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are
   assumed to tile the address space.  (This is slightly more
   space-efficient than using a size).  Non-text-section addresses are
   skipped: for now, all the users of this interface only need
   module/non-module information for instruction pointer addresses, not
   absolute-addressed symbols and the like.  This restriction can
   easily be lifted in future.  (For why this isn't called
   kallsyms_objfiles, see two entries below.)

 - kallsyms_module_names encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  Object files which appear in only one module in such a
   multi-module list are redirected to point inside that list, so that
   modules which contain some object files shared with other modules
   and some object files exclusive to them do not double up the module
   name.  (There might still be some duplication between multiple
   multi-module lists, but this is an extremely marginal size effect,
   and resolving it would require an extra layer of lookup tables which
   would be even more complex, and incompressible to boot).  As a
   special case, the table starts with a single zero byte which does
   *not* represent the start of a multi-module list.

 - kallsyms_modules connects the two, encoding a table associated 1:1
   with kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   kallsyms_module_names list).  Entries in this list that would
   contain the same value are fused together, along with their
   corresponding kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in here do not really correspond to an object file, but more
   to some contiguous range of addresses which are guaranteed to belong
   to a single built-in module: so it seems best to call the symbols
   kallsyms_modules*.  (The generator has a data structure that does
   correspond more closely to object files, from which kallsyms_modules
   is generated, and that does use 'objfiles' terminology.)

Emit a new /proc/kallmodsyms file akin to /proc/kallsyms but with built-in
module names, using a new kallsyms_builtin_module_address() almost identical
to kallsyms_sym_address() to get the address corresponding to a given
.kallsyms_modules index, and a new get_builtin_module_idx quite similar to
get_symbol_pos to determine the index in the .kallsyms_modules array that
relates to a given address.  Save a little time by exploiting the fact that
all callers will only ever traverse this list from start to end by allowing
them to pass in the previous index returned from this function as a hint:
thus very few bsearches are actually needed.  (In theory this could change
to just walk straight down kallsyms_module_addresses/offsets and not bother
bsearching at all, but doing it this way is hardly any slower and much more
robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

The resulting /proc/kallmodsyms file looks like this:

    ffffffff8b013d20 409 t pt_buffer_setup_aux
    ffffffff8b014130 11f T intel_pt_interrupt
    ffffffff8b014250 2d T cpu_emergency_stop_pt
    ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
    ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
    ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
    ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
    ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
    ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 ab t handle_timestamp  [liquidio]
ffffffffa22b3b50 4a t free_netbuf       [liquidio]
ffffffffa22b3ba0 8d t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 b3 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 203 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 16b t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 1f t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 1f t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 d2 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 9c t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 11 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 11 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 2b t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 738 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 368 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 37 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 18 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 2e t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 69 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 92 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 175 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 ab t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 4a t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 2b t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 7e t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

Those symbols that come from object files that are genuinely reused and
that appear only once in meory get a /proc/kallmodsyms line with
[multiple] [modules] on it: consumers will have to be ready to handle
such lines.

Also, kernel symbols for built-in modules will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am open to changing the name and/or format of /proc/kallmodsyms, but felt
it best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly brackets}
or something to denote built-in modules: it might be possible to drop
/proc/kallmodsyms and make /proc/kallsyms emit things in this format.
(Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)


The size impact of all of this is minimal: for the case above, the
kallsyms2.S file went from 14107772 to 14137245 bytes, a gain of 29743
bytes, or 0.16%: vmlinux gained 10824 bytes, a gain of .017%, and the
compressed vmlinux only 7552 bytes, a gain of .08%: though the latter
two values are very configuration-dependent, they seem likely to scale
roughly with the kernel they are part of.


The last patch is an RFC to see if the idea is considered to be worth
spending more time optimizing the representation, which adds a new
kallsyms_sizes section that gives the size of each symbol, and uses this
info to report reliable symbol sizes to in-kernel users, and (via a new
column in /proc/kallmodsyms) to out-of-kernel users too.  Having reliable
size info lets us identify inter-symbol gaps and sort symbols so that
start/end-marker and overlapping symbols are consistently ordered with
respect to the symbols they overlap.  This certainly uses too much space
right now, 200KiB--1MiB: a better representation is certainly needed.  One
that springs to mind is making the table sparse (pairs of symbol
index/size), and recording explicit sizes only for those symbols that
are not immediately followed by a subsequent symbol.

Differences from v2, a couple of weeks ago:

 - Split the series up.  In particular, the size impact of the table
   optimizer is now quantified, and the symbol-size patch is split out and
   turned into an RFC patch, with the /proc/kallmodsyms format before that
   patch lacking a size column.  Some speculation on how to make the symbol
   sizes less space-wasteful is added (but not yet implemented).

 - Drop a couple of unnecessary #includes, one unnecessarily exported
   symbol, and a needless de-staticing.

Differences from v1, a year or so back:

 - Move from a straight symbol->module name mapping to a mapping from
   address-range to TU to module name list, bringing major space savings
   over the previous approach and support for object files used by many
   built-in modules at the same time, at the cost of a slightly more complex
   approach (unavoidably so, I think, given that we have to merge three data
   sources together: the link map in .tmp_vmlinux.ranges, the nm output on
   stdin, and the mapping from TU name to module names in
   modules_thick.builtin).

   We do opportunistic merging of TUs if they cite the same modules and
   reuse module names where doing so is simple: see optimize_obj2mod
   below. I considered more extensive searches for mergeable entries and
   more intricate encodings of the module name list allowing TUs that are
   used by overlapping sets of modules to share their names, but such
   modules are rare enough (and such overlapping sharings are vanishingly
   rare) that it seemed likely to save only a few bytes at the cost of much
   more hard-to-test code. This is doubly true now that the tables needed
   are only a few kilobytes in length.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>

Nick Alcock (7):
  kbuild: bring back tristate.conf
  kbuild: add modules_thick.builtin
  kbuild: generate an address ranges map at vmlinux link time
  kallsyms: introduce sections needed to map symbols to built-in modules
  kallsyms: optimize .kallsyms_modules*
  kallsyms: add /proc/kallmodsyms
  kallsyms: add reliable symbol size info

 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  21 +-
 include/linux/module.h      |   7 +-
 init/Kconfig                |   8 +
 kernel/kallsyms.c           | 303 ++++++++++++++---
 kernel/module.c             |   4 +-
 scripts/Kbuild.include      |   6 +
 scripts/Makefile            |   6 +
 scripts/Makefile.modbuiltin |  56 ++++
 scripts/kallsyms.c          | 642 +++++++++++++++++++++++++++++++++++-
 scripts/kconfig/confdata.c  |  41 ++-
 scripts/link-vmlinux.sh     |  23 +-
 scripts/modules_thick.c     | 200 +++++++++++
 scripts/modules_thick.h     |  48 +++
 15 files changed, 1301 insertions(+), 66 deletions(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

-- 
2.32.0.255.gd9b1d14a2a

