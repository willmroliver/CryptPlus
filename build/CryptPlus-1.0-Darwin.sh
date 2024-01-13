#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the CryptPlus-1.0-Darwin subdirectory
  --exclude-subdir  exclude the CryptPlus-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "CryptPlus Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
OpenSSL is available under version 2 of the Apache License, given below:

-------------------

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions.

"License" shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document.

"Licensor" shall mean the copyright owner or entity authorized by the copyright owner that is granting the License.

"Legal Entity" shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, "control" means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity.

"You" (or "Your") shall mean an individual or Legal Entity exercising permissions granted by this License.

"Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.

"Object" form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.

"Work" shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below).

"Derivative Works" shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof.

"Contribution" shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, "submitted" means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as "Not a Contribution."

"Contributor" shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.

4. Redistribution. You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:

You must give any other recipients of the Work or Derivative Works a copy of this License; and
You must cause any modified files to carry prominent notices stating that You changed the files; and
You must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form of the Work, excluding those notices that do not pertain to any part of the Derivative Works; and
If the Work includes a "NOTICE" text file as part of its distribution, then any Derivative Works that You distribute must include a readable copy of the attribution notices contained within such NOTICE file, excluding those notices that do not pertain to any part of the Derivative Works, in at least one of the following places: within a NOTICE text file distributed as part of the Derivative Works; within the Source form or documentation, if provided along with the Derivative Works; or, within a display generated by the Derivative Works, if and wherever such third-party notices normally appear. The contents of the NOTICE file are for informational purposes only and do not modify the License. You may add Your own attribution notices within Derivative Works that You distribute, alongside or as an addendum to the NOTICE text from the Work, provided that such additional attribution notices cannot be construed as modifying the License.
You may add Your own copyright statement to Your modifications and may provide additional or different license terms and conditions for use, reproduction, or distribution of Your modifications, or for any such Derivative Works as a whole, provided Your use, reproduction, and distribution of the Work otherwise complies with the conditions stated in this License.

5. Submission of Contributions. Unless You explicitly state otherwise, any Contribution intentionally submitted for inclusion in the Work by You to the Licensor shall be under the terms and conditions of this License, without any additional terms or conditions. Notwithstanding the above, nothing herein shall supersede or modify the terms of any separate license agreement you may have executed with Licensor regarding such Contributions.

6. Trademarks. This License does not grant permission to use the trade names, trademarks, service marks, or product names of the Licensor, except as required for reasonable and customary use in describing the origin of the Work and reproducing the content of the NOTICE file.

7. Disclaimer of Warranty. Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.

8. Limitation of Liability. In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall any Contributor be liable to You for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this License or out of the use or inability to use the Work (including but not limited to damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses), even if such Contributor has been advised of the possibility of such damages.

9. Accepting Warranty or Additional Liability. While redistributing the Work or Derivative Works thereof, You may choose to offer, and charge a fee for, acceptance of support, warranty, indemnity, or other liability obligations and/or rights consistent with this License. However, in accepting such obligations, You may act only on Your own behalf and on Your sole responsibility, not on behalf of any other Contributor, and only if You agree to indemnify, defend, and hold each Contributor harmless for any liability incurred by, or claims asserted against, such Contributor by reason of your accepting any such warranty or additional liability.

END OF TERMS AND CONDITIONS

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the CryptPlus will be installed in:"
    echo "  \"${toplevel}/CryptPlus-1.0-Darwin\""
    echo "Do you want to include the subdirectory CryptPlus-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/CryptPlus-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +205 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the CryptPlus-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� ��e �}	`E��$!�p����LB�� �A�1�����9�\���&�`��x�kVq��B\�v��U?7��Zx���fU��ի����L����SIuͯ�W�^U�:��{ia�x���9)3�!\0�M�P��L���tfN̜�>��LK������4c�T�W�+e����A�eˢ��'��%f)�Q��ek|����
� ��<���s���3�'f@�gfL�`g��am�����~��P"cJ����1	�m����`[�<����-�q��
��TxW�F�X��7i8^O7�����)��\Z���!鮴�j��^�P������|���S���L����a�l<�������t�F�3m���dUaI���dY������p4�D�nG:��N�̘?o���Y�pYh̎��M$z�8�^�.���r6��X1�e�z�$yyf���%鰞/�|� �9���ve�Re���p`��hdX��������|y+"��������n����e]��v��m
�qc�E��"���{��D)o�V��k�?���y��:s���/.��t�s�eJ�R���o��r(�d&ۋj�I���l���W���/*��+_� �-)//ʚ $#l��N�iT�:N=���z.$Js�)��Q�d��E|���	��֔Wx�O��������
k���%,�313131313131313131313131313�fQN��s6|aϩY۞S�jϩq�I�˩�8�S����U�%�����_�Ο���Pcd��k*�H�v2��u���rDz_Э�Bt��9-e�F�_m{N�\`�_�^�`�p���Q;�����"P�ϩ��ű,�����l"&�G-��0����u2�k�T^^uH���@�u���^�AF5kw���x�!(B�k�7�l$�g�SDٓ�y9��]��z])�Z V��5wlD{�L���!a����z�6z��cuK�T,`]f�M�Y���Q�D�mУ��`�bkZrj���'�g�=&L{�H�C֬j�X����U��>˿��o��V����zi-ܪ=��l��Q���u(HQ	A��^z𜺄���&�d:�A���AE}��g��g���ء�lMt�P�6�ֶ�����2�/إ��3�I�Y!k�T���}0�j=A�Wr�O�6h�W��'��Z}���X�%��Hq7׸^Š�c�f��iY}A�s�8UN��g>����1|��Xە�sj�E�Yĩi�˦]�O�	�v��pj�j}CBW#�@t���:��~~�B�*�jl��s�B������y�$��;�����u��益�~�l��o@��g�P�f�_��d��4Wג�j\���q���x��U�)BֽZ����s�(`�,D��Nq�im^�]�\��y�!��u�-1�Y!�X��_�Y�Vᙳa����Mw4�P:��6�ڹ�g$Ԍ���`Wog)��I"T�~qZ(-�?I���ZԈ�z��S^�B�I26vT6���g��.��䃯A�V�G�h��E���j�x�P��0>'2���%� _7V*��}T���GM�#���C��ìh�5����,�D�$����WG��-h��J��A�S��w��wL#Du���A�r��YGT�k�*֯����NUq�*h��'�\�e}���*o�I�m��d/T�������c�s��ݪ����_�L4�0�K]7hCo翰�jݠU�Є�J�w�:7l���"D����w|/ejh(����lsCY��2b���j�PjZ�E�M�-�S��*�����I��+L����Rˋ�$���֛����C#�2*|���d��Jm|��]�e[��,������ oc��n�VR~0�g��(y����N�٪�9��ׅ�t҄3r{$��b�C�/�Z��j]�4K��ǋF:��-�9=�/�(�"ع��?Y~Ǉ�<|�]t�Z~�����7�H��K���n}m�*UwY��7��²�"�W7�E���`��#�+�:�MbV��y�<�yX��N�s���F+g�Ee}{:ϲ[���P��Z#ʣw(����.�6��sꠎ���6�����D�TV�;:"���\Jb���mj�R��l�-���đb>l�O!#Б`Z��
\��ة-��3����h0,��T�OД^��L����-�u�����mr�D4E�)�24D� ^�'�TGI鞐�RI��B�?�XQ�t6���~�&�+���޺�BC<L���VX�ꔎh:�����ʿ�?�zX3�u����܅���y|fߺ��.C�m�]A�y_Z�L����\��-j�_�����D�B���"jĪ��ʕICN�(@�-�%k\�T��J���u�8���&/ �J�lʦ��2\[N+�u��qa}>�C����;1'n5��Kt�s���J���H���0�i�JJ����������?+�և���P�j�3���LHg^��lE�&�3��S(J�Zm�Q���.~j]�'421�8R6�S��q��@i�p��/�u�וflڸ��a����?��s!�"�X$ov�#6 �Sv5󙸹�I�A���o���m�G�n@�RV�.�]+�$���� -5�}r��@�=x9i�aef���ˉ�+�jR͚�D�6�S#��T�����?����a����)}P[�&���I�S[�,{m�|W����fԒ5B,e0�uN�������k�,eS�N����MFLz�B�6����������
�l(5} }0f�l{]M�t�F�2kd)[3թ�죍\<�S6���L�ϩ�-�k� ��L��Sv-�H4ы>�eQk���[�Ŗ���v5��h�i�$~U�~Ƚ)e�D������������׸�����R�B ���|j��A՛){�u��Pk(ض�"iC�\�D�0}�½�*Z����&NF	,QzGio����l��״�_����Ԋ�Bk?��b]�=����!�N*o=��z����
\��Rv��Wj^&���j'�k*���V���Kq�<+5��6��	tF�{�:��
ůnQST��R@�����M������L�Y����I�4�JSa���Ώج���X��;r��b�"��}�.g�����`m>��I?�:��_�{����Z��S4�ui�a����	*�����hr������@|�U��Y�sMe{����]�V�	�X�q~��Ud�]?�8ܭm枕rÍ/�h	鋔]�?pP0�U�0��X)&{e?�m�Ѧ1�+i}�i��~GNmf��!�Vh�`a�A�����s�IL��u�{r��G쿫����R�C�����������o+��EᾒB
�h�1S7�9S�S6���W�?NU��)f�.�7W6��Y��p�\z���vulvu���H��)�Ȱ�Z�3A�~�����d�2P�?�H��.j�8t���u�ϣ��}$�v�M�%9'kE���@���"�&i�M�	EY�+��3<W#&=	�-q#K����\LC�mX�f%�(5?Of��d�i.�v6�A�@���j�ce�� ��4aO�ʟ}(g�7)�wC�Z��_-L�}@�����ώ0y�Rۑ�S�imX�I�)��8e����W�(�4�����3�m�u�G����~�u{r���%_;�א�ٞ�η��mئi@2�/8։��P����lS�SW�G�����h�{���F~��X�fhT@��ڧ)ej1��9 �]�Zח��x�	m'5�	8my;"������ヾ�D��7��J�77B8}n����Aj���mωA����#�΃����]ن�V)fyY�g`�����%�?������_��ɫF?X$��Z���5Ps��+j�����V��.��8ߩ��t9<�M�����/i�9��m�������7��˥���S���Q\���o��G�H)
](<.�����@#UЧ�y_��l�a���mV���O�}�S������|�?N�ak������u�T����q�2	�O����l4��S�c7WTO�-��K����ް�;lb*b�6�m�����~�-�S�3��7/��oN�|M�c�����Fu�H%�?:��U'��������^W�شܟ�*z1M��押�����I@щ�]�<]\��e���O��Y�'�e=�䃵$�w?��w�rj�rvuHsMα������#%���#�c��ѡ��)�)s����S^��Q��#��⟭�7Տ��r+bh��y�h��[�|P�r}�����A�2�|�����/����HPC��v~3l�f�B�Ծ�_�!o��k\_�
��λT�P��|�Ek/��o�\J����MkD��v]�����H�������Z�.�Z��qo�ڃv�pߖ�hS�P}�$f0��KI�P9�K�]�̿�F�5��(�QBQ�K����ϓF��I��wɹm��v�'����#{ʭ��Qx��\ҵ�|�%���h�_�s<Y�v\M��~W�ӎp����:���cb��H�Y:�Ӌ�X���	�6ܺ��r�aX��ǫ�I�Jϯ�iaLwF�+��qxڎ�!����,��b7���2Q$
�&>H.wv��	��H����5����S��z�b�>��D+oLW�M�V���{�i9��[�Y�?rފ���Kר�^�:����f�wh�6�\���zF(����6*66N�@�c�b������;;�_܅�j�8%ԧ����m��G��?�=�%����d��A�[�!ߢ��X�/`��t����,n� ��ú�fE������"��ѯ���_���ϻv���H�__�l߫�k��YM���>�yn)	Jc�U����>񳮧We��ӾL���^O������c�Л���$�^(4���:Ёw����>��v�xg�?n��~�C���� ��u��&5/�E��ч���h������"�W��Y�k'Q����� j�z\��\��Qzl�~H���5�/���ڶ9���^��	�/�i� ��$�|��!&_�'�51�Ђ�?sQ�Xg����_E���>5���5{���L�.���m����j��6���j���'�<��$�^�8���_��(ccAk�^{\/K�^�5�LwD�Q�R�Y�>]c��1�A���t#�A����%��um��8��V�}�=��
��h��2���l�,�%Ǽ��C�b7b;?����<��y]�p��ʚ��>oAI���P����Or��b��sY�^0�kϦ_A8ĻY�|e�FD$�5��{�YB2��"��ၘr�H�����Mn���y/���NG�.�?�������j���?7a`�&�(�IVFzZF�!�jP�/5JX(���dA��?�����󴂋8����w���qN���D�!�	���iDDB>[x4)a��E���b�~"�V%�8�n�����T��@s�=��������k�v���9�������Ƭ��w��w���^�+�;��=$K,\>U{����V(�!Wd�lx �%R�	��u�4�X:��F�RW��or��!U@2�*g`4}	�
0*\~�	�8�"�&y�@�_O�M�PI�{U(U�5�ȇ�ן�G�<�$1��mۯЭ�,��2��}�w��(�9�<Z�ǡ��ϟN��O��l��N�=���C�q!4�<�v�a��
lֹ�&�O�꓇��eo��
9�$�SG��E��[�Ê����0$���	����g�Vp:UƦF�Z?����Y(��2U�臕Y��_V�HVn;�/���K�"9-�V��FV��AM��D?��0q�0S��>�4����+����>�8�҅G�a�9Q����!���r�g�쬇��ڰ�eV�����2B]�qXYl�^���a���_C*�����ae�l���������>����&=�H�ʗ�FV�)sX���/�H?��0QЌ%�߶sM��%���֟��/qj������`|GV~�eXi��`X��į��+Su���q���4��!#+/�����xv�
7��z(��ʾ�W�u�YE�~����Ө�����8m�[�_��;���Uo��j���ST���x���,�
����
��s��F�b����)N�����>�~�g�|j���߶kT�����h��o�Q�m:]Z]�ڈ��9�n
���*�z������/�)�2j�'%�R䛰+����}�t�~U���ٚ��&�5����Z�?��Z9�㭙&�0��0���ҳ�O�`�o�`��¸�Rc^�����H�^� �:!�<&M���x�ﷻ��4B��ş9�� �e�b�9�jp�n6&�k��7x%��~Q8,eS�$��u�'��^���lM�3���xE� z\�����w��C�!u~��z�&�\�%-�.j��5��H�{�\V�D�y]&2oD���Q?-�'�t��-/�S�֞�=�=ԞBB�w>E��fhB�:�m9��e�}�X�IOz�����|����b>�^(�kϦ{H(��9�iT��w�|��ʍy�/2�[x �8�;U��ʖP��^r �Zl�!�s�߆K�c!HD|䂯���E�*��q�%�߭�иW��x��ŉY��C���<�^"չPՠ�E����6���z���热��Q�S#�W��ٛ���{N����`�Ѡњ0׶�!�4����&��7]|�t�-�KZy�vY���[,��������J�rC{sO�GJuNj��U��_}����+�ꆀ��uq�r��D[2=������r� ���(��i��7�ȕ_���Is�vE��H��R�F�3��-�����i�1�aas�I|�b�l��|��~���Y|4a������xvH��L��-ϗ8��ݚ��r����16���9�0#���,�~oe��O����;
���l���	� _K���T�M��x�9���i�ObԹ�2z���%��
�OXb�>Z)��w���T��T�z`��/�IP��F�����$0��85�0(���E�8�����=YIJ��wv�����ut��g�����	l	}uʧ�����%<C�yS5.��I�������Bk}������^��L�� �B�<�t���g��ݦ;;����?#��t��|�����-������!����{�Q���ܟ;�O|�����|h���xW�M���q��wL�Y��|��-�L���U�r^�Ծd�߰�7M�����)�}~��U�<����+6Ƭ�{����?���i��K�bϕm����@��!X?��������-Λ�������J �h��5�nn�N�'s�`�MʩI�S���I�(GM�h;���.���)/�}��$l�7�W�|��7�q���!�V�l��w��'tO�m�q݄?nC�Irl�*�#�Ӌ£Xz�a���h���4Y(H�U���'X���|208+)�(��'O���K�A~.�*I�X�M�cR���	mI�)�V�%������;��!�ە��1���X�'���'��C�A°,q��n����˩��ԞI��i�]�8c��ް�g���Ϗ�Y2ݓx8=���}	�y��AN)���J�.�=@z�s�o;:��X�o����D�Hʃ�)4�h�k��'�\9�֢_k��iV��r���o\�3����b��r�������gC�}�`"�� >ﰟ�hq�p�w���:FC��L����h�Ð��>�H���������G���.�/�p�O ߯z>�/l�н��'"�/���Te��)�|�� �v}��U<sӨ�Oz��+1��9�R>l�_��V�}�y��+zr�)u*��RK���3X��c�se�K�)���t���hσ�����=�����w?��_�>��#T�#�NRGF1o��R6�t�?�~���n��3GqIHa2ߦ�<J�?B���K�9�I2�|�d��!���q�C�����>�����CqZ�w �Ԇ΢��0���m�KY����rj'��ZK�|~S�2��3Bg�����P&0�\�5�y�%��v�I����_U��{���INjS[��|�ӏ��0�>��t��Y����ќ���?��5�iV�����z�Y���-�c%O�>�h���#�W��_匦�5�7��/C�8�_i�r���g����G�'�y`��t���[�$m���/��v�����cC ��g��[=(�-R��/Մ	���3��>����*��QgjM|���?�ŝkF�=#��?��'�W�?���)n��x*�/ѫ�(�s��q�X��
��2�_�H�[ttDؿ�� R��OۿP�_�9>y�C���~i>�2�d�2ى�~�s��~�;���/��Nuh�r�R(���q�aZ��>μ~���G:����#�?E�u�'�]�y�s�?k�I����H��o�D�?�������������zr'�g@���Y{����?4������C�G�L�,�؃m�;d�ć��Yn�'3��\�N�ȭ�OG�oWoR5�N-r܎��+�3�P�M��c4�M|��TU{��Ad��>�i��������XH���1��6�W��&�T&�:d��|_�n�~(|�G}�Ue}�m |�<s�T,
�ה�;�!�������1e�����_1EW�J���R�Ba@w^����Qk���r�&7�5Ua�4�9�$�Ho?j�5cd-����O ���Y��ԸтM�y��:�"���'�����Ď�jxK�ْ5�W������C�݌�>F~S���0Bϯܾ�ˇ|�w*�m%*���<���<���iyfD-�a�k:�ʗ�S7�d�?+��͏?��~�$~�Z���������_i�_��g��z\�$��|1yRP�\m�Ct4�n��_���&2r2�� 7tg�����D������Q�Q��i��C�X�@ڽ��N�e�D@7� �N���ݴP�׽X;NR'^U�������V���/�7j�dw����xx���<?gטA�m�I�����I��ҳ�"�z��t�d�h�ɓ�G����8��-�U:ł�xpd\趺�1���Rd��qx��x�N�v)�1��㍥�G�� Q�[��J%��J�*K��)�t�Vb�(ёE�W�+q�-B�0�6A!צU���ڪu�V-O\����
����΂�2Y��H����q��t��~J��0&�HP����T0�ܰ'5�i�o��^��z��gIV�P]y��|^����0V�"��	&

�3���թ�X9?7_�{(�՚�o��6ɧB��+��lx9U-�]X�UZ�VY�d�Y�p�=Z����c�b�G��a�Jc��	<��\ ���RY�f����<j�Ǚ��i��ͺ�zS�4��3���!ŋl�b�D�ܧ\�j�BP�|�����@x��c�+ݬ�uP�CL*�ƯF|���>��8(t�ՏʵX]f�����1&|�O>�hXLƉV�E���a����ĹSy��tG�#�e�Gs�H�"�ӏ��Aߣ�84u
ڕ���:���4��:��=�P��C��!ޏ��3��SLߟ�p;�>��3��hۅ��ܡ�;uߟYt;f�`����NZ������̿��ʛ�[<���iMߟa��5�a-fBߟ)��3���a�����Cy�˛���z���Pz#о��'W��~������J_ݤ��=���|�����aT�?���@��=��1<�c��o��s�7T����"m�m�/�=��HL��P�4Lk������)���ߊ����}�:�6|�[;:�ʊ�X���=��事JK��~���f������P4�~�K'ߤI�Ѿ_�?4��]Z��*����wh[P��*2E��wh;�G��������SItߪ��9+�K�/�sT����r��	��"�ox̔���i����|%S�G2�6S3lC::��G�չA�a��+�Ƌ���e�b�\�����������hR������ӝ.|�$e�q�>�:X�Kݥ	�������7��H��g���9�E��6qt�e>k��{���H�<.D�����	a4"��ןO�`�m�_xX�����Q����IW�a1���s���&�#�+��u~���h�n�oĬ��S�?�>���[;:L�}nk��5�{2�<�Gf���4�[��f���[O�x���i!�Z%G���ߡ�J�{�j�[�"�k1�}�A����ЍZl��S'�6������kB���	�Oe��G�MȂ'�x=�C���T���č��[��/]k���#�,G��?�������B1RW�����{��hі�^I�l�wA>��ě����6�ck�J�'ڥ��~��g��i/���M����X�x������vzK�Hݼ�Y� �"�8�Q�{��8�m����+��S0�FR�|�g�ݐ ?e+ݕݗ��r�_�����B�Z�)���py-�x�>��[��:�]_G2s��e�5%��|)�e�a_���Ɵ|�Z�xȢ�����ɥ$ވ�|��ȷ�կ2?�k�c�V����x�}�ӯǭ֓V��[��Kx�d�BS��>T�sey~lH�~>\���_裗�0��?���D����G��T�nI���C]Z6Պ,���u���;�粃�.BJ�d�K�E�1��2�z���2�L�?z;����1�R�3�X,)�������o�O��߯�sޕg���֣�%Y�w�=z*IL�]\V>Ӛy�ߌ���Z��|2�Z�����3�#9v�qG��?�w��~Y>*�x���ӳ������_�wX�:�#|�y���L��Z��˯��ra�����=��߷7v��;��c�+>'oN2��a��ƒ��X�I�^�M�m,�3�X�-�r��L_ۣ�.���a�G�%4#j<5��% �翦�g���scg뗰��M{�/:xGL�b�G/�������3���<��a�.��+DQh�8�c�'Y�/�ۧ8����M���\�V���?`�xN���7'�th#^:�$�\��R� I���R�_�O	��NG���קz� ��Z?'N��[�L�������k��Q���������
-�S��� �<�(S�Ŗ�^|�/ۙK��̀r��ft���tp�x��N���0k���x�0<U�����Qo��x���S;��f��[l��x����.{_F��<�ѡf&��剛tI����l���v+[�z���{;w�'3p�X.3h�w�TeI�ш������H��U�T�L�(Ŗ>/�@}ga����Nu�G��7FZ����F)�&!����PR6�\�  �_����u �?���BшH}`c��R�@�xސ�ذ���N�0��6��pb�~��EVD�x������+�^'.r��y����(΢�)=����Ɖa��{��o6�;�
m:�MܚC�I6}��\qO���(�7�<.���?ɣI��c��h?�d$y|�D���'#��d��<j������q�g�w;N����k���� ^��k;^���x=�W6L\mx��k�&�^����v����@��k*^��u^G�Ձ���:�'�u^O��8���W'^��׉x��שx=�g�5���יx���x���yxu�5��u^W�u%^��Z�W^��Z��*����x�
�W�Տ��x݈�k�Z���x݂׭x���6�ބׇ�����1����x�^����xm��x}��������~�W��o�z ����?��g�z�u��G��p���R��0��XV��
�]���'��_*�IYC�v&`ݢ�a�J:�ˠ�\��S�ݥ$�+�w����^Wz�nco)��J{(;��3���>S��J���K)���k�v*lY���Q9���Z���xMM��U��cs���4���8��k6e�-��l�K�s�6.��8V7���q	�S�����R{��<�1(؄7m�۷����.^2;����{���exBz��ER���<|L�L�ь�Np��SCew��q����>��|����?�%|Ϟ�O�W<� |��p{"k��L"ۘ�|KJ�ғ}������$��{%?݋��kN���eB^�z�`^���v�'��a^�{$ܛ�:z$�Jd���SI	7�d_'%7�d1��{%�Ћ=�k)���̞u6v�ԇm�N%���>R�߶�;��{qɯǳ{�y<�>�n���|"��Gr �}�x)��MJn�ɶ�L~��(�<�k�����^+B�?|�NvvȊ�=�Y4G�\W�Jv�Y���>s#֏�!2�V�PX�RDiF��d�3{©l�M(7��Ҍ釤wk{�%۷�u��;o�}Y)c�9����!�:���t�,����'v��}
[���Y��t�ٌ����򆿫�uJ?��m�ZM���p1;�L=���y�Zg������9k�Eo)�%�s��f�_���3�m��}�~��P{-���p��w{��D�����I�1�~��g�_z��{�(�2�7ֿ��RƖ^�Ga/D����>����o���̦16-�6sN�zKfS�����5G�>�ع*��ج/�7���|;��,/H��]���KJ�W�<1�'�hc��Ύ�?:����rE���K߇]��e	曫�Y����̌������[_�ڋ�*��%b]Z�3���r}��֯i��:��1˝���,�V��Z"�l��b����-)//��`�4��0�S^QVX�\�p�w�����Q^�WT4��]���W@��9����s,/�p`�L3�����]���[�+ȫ��}f��A4�����$?]J�1�,\�-7%D/J7~Q���|��¢�Ң�*o�xwQޚ��e��]TY>i�//˗�N����|�kނs<�̥�:����@
�e,;�-[V��̘|XyyW��+Y���\�:
�e��S%����%�EE�#��PE�l��%��S�R�B̘���G�q,�+,�0_^Ad�2��Y������w��@���z�@�[V��".�L>H顈E��R1=Z�����fS��=�u�g��Ųl$�_'w��Y�-1y���L4��e���0
���U�*��
��
d�m�z܋�e�;m^�;��郌51,h\���!�<����A����d`����8Ʈ�?���\?|ܖ��'z�u�e,�׌O���mp�Z�wr�u�bp�a��n�w�+�);���*��ݽ�;��O��t����X�#��[��S���ֻa�nC.�np1��x�?���׾x���&p�+{@�0�*�}����(>�nVc�"]�y�7ܖUP>p�!��!��&�����g�]��k��+�]r��}܀��}�c��P� >j+�m3�	���f��/�끟FH3��[��@��u�
���ື3�\�m�m|�Ҁ��2���^��)��1����kz����q�3�U�O䠣���R�ͭ@s�6��?D��3�%p��z ωLq$�\{2%���͔�������@����ALiG�S�&L �Ù 7k�	e��((�h�Nh��� hsm'1�q�ǔ��P��@7�;	���:3�O<|����	<��Ş��[���������@zG�<�d-��-�t�ă�@�>�����\�ނ ��Ay.|1�����R��0 n�z���K�	����]�C�B�B�s`��7��D�0�K�J!=��`�J�m���dp�	mҿh��w�t-��Z�,����m-�x�od�ݯ�k#7��xr��An"�I��$����M&��}�M!�Nn?r��;�܁�"w0�C�M%w(���N�r�!w$���u�{,�Ǒ{<���=���=��1�%�drO!w���{���u��Fn:��� 7�܉�N"w2�SȝJ���A��E���f�;����� 7�\�3�=��rg�{.��ɝC�\r�;�\7�瑛K�r���������ɽ��ɽ�܋ɽ��K������<r���On�^r������������-"���rK�e~313131313131313131313131313131313131313131313131313131313131CF>{9fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb&fb��8���1�Wхœ�
֩��e�`,��)z�K�����.{5���Bz�3���v	��`���l�Ҁ]�l����c���`W���s`�;2�)Y`�n�2���K`�<�W���?��`��`�T�%` ���Dw\";8l�$v�)�����l����#�q����;��Gov0�-`?�Lf�Mf��}��lU_f��l`O�3�`O��lw�֟ٶ���?;�l ;8s � �q;8u0����lӇ��%`m��vؤ�̖5�\
�V���߃�1�6l.�%Øm� ��M�l`�gqW��{8S^��> 6~��D�G0晑{�{�|O~�7�̳���y@q^QQi~^AЕ��񖕕�y�+�
K�K���
��|�g�,w�+�3c�bO~�oM�����Y�]e�[��_a�1'�.�.�^t�w���[����d{����*f��y����J
�����|yD7�p��ܜ�LI�O��Ub�-yӒ�>��l��C�y��X':��Q�DFޚ�{��$ZP�3�h�B^�3x�{J�#���2La吧/�,��\P�-+��yx
AP�H��-ӇX6���[�-���/�%��,��qO˝6$^-�2��� BHeaI�D��&��H�yٞ�k*����ܫ�E%�
K
<���J!?υ�2��|�.ѡ�2K}ޒ��"ѿ<���y*&x<ii�K���)�Y����g�
��ey���].�9{n^Ei��q��9L�V³��$=OU�w��N�5)��Z�׵`�GOa��]�RY��,���V�r�-pz�M.,-�@^މЄ!��
CT���.P-�Hw�g�!�R)Ƞ�P�t�ҼO^YY�l�2ڌ�"�(`�MELK�^ͫ�S���uF�:�[�,*��\�|(Lq�h�����@���h�$�:�X�
UD�:2��T�Z����9=��"��SX1}RU�D��9q֜ⴉX|��'z�7��B:*bFA)�Vf=-h���dz���������L��J��7�8B������2�U��02ޥ�˽%ek��Tus��2�RڢrW�$24�!����+c¤ro����1U��mx*,-�zނtOU��Tb��p�T ��5�|A�*h�6���y�q*�`��7%Th����@�c2�7���H��N:#���#3_�@14�F@Sk�Xu+�P��=�H�\f���:!�j�g�D��>lJ+"Q
� �9�Kab��A��k�2oŊ��U�f�rĵR�-��R�-+��r�#/�e�U_�CϷJS��F�E�+�
r8���y����,:�T'<�'u����|��'z��Ի��_�å�WC�!��)QH,_��e奰l(�X�r
��<��篸&E�EF��ye0U-H/��M��-���~{��}��	p�K�\~@�1��A`�b_��d4�a�������X�|����\q�_�R�ۮǈZ��%����li.62�Ŧų�D��
�*vq:\�Ƴ�m�?�����_��f��l��W ��"^���`���	>�_c��ln�2��rQ�RO~�
vF�D��=���l�zֻSAN�V�0ӫ��JGd�����6>$�kyX����E��%�o�D������T~�-��M
vc����q�n}�ӧ
T�-q�+
,�ZS�Ƌ��\=��|,TW�H�xQ[?�e�m��g����3`,�`[�l�� ��J�W�R^��,�.�{��tT�H�b�D.�	 ��D0����+����lkB�����KxEB�#�ב�7�z)A�}B.{}���ؑ ��"6����eU7�Ҹ��OK�e�T��pkQ��O�]
�����{d��q�m�c~qi����{�p;zT��� B[��x�(w%b����É�wM"��DoɆ������D�������j~")�O5H�f�$��'�4�/>�]���0����e��1aF�o��L��C�����܏M�~���nd�tRzn�x����{�{%{>iyV��̐����$ �[�Ͳ�l�	�zV���Q���=�ط��b�	��n��r���;�s���-�$3��fX�k龞PK7����Ŭ�U[�7�D=���{P_��k[z#�m��屽I3�?ze�C�Dmm��㿈��RmBI�����
3��0��Vow��]��#��{��s�V�c��$���5>�ͤ)�횁k����U��d(4Fj{�U�ﺅ�>a������u}���p�bl�_���}���V�;�b��d��{�B�~�9�N��u�BZ���y>T�m}��?����tu�
��&f�
�Bo�2y���\�l�f_� �l�E)�Ad�,�2�}�	��d"ֶ����),N�l���Е�羕�Ei�/)@�ET�oŵ�A���.i=X%����vo�a'z��l+���ު~�a2�b�}{�2����%�w����~���[q��Ƿ�a�`��w�N��l3�x�-�p����?(�K�(p)�f��o�6��; �3x�V���.d?���{���Ő�A�J���={E!{r�����@*�&�kf��Z`� g�"��O�u��4;\� �m�x�l1���̾ܐ+2���}#3;(3[?���@?\72^,2�i���s����E�n84So"��7g��g��`ѽ���.يZf=j��8��>T��(>6dBh��r�v�a<w�'�d�D>�$M����^��������SњT,����RA{�B��g�3
`�m����ev�dv�V��C�2�M�ʨ
%E֩��ۡ�:�5TLv��>��:��zf[�2�ߞ�&�I�>d�k5�Q����Ӹ�i|���6�X��\n�b����Ǭ�_��AﷺĸY��5�/'^����ZgoƆCkh��q�D�Lt�b��p�D<-�H�a�yy ��l��ߋV��B֏��G�
�1��T�W��#�ۺD:��p����٣���# ��Px��҄x돁�	?��M�$
�m=f� �c̆!��ǴǏM�4�C�e��t�PB�5^���Q74��/|d��
iKz����6RU�z�' 6v�|���t�w$N�Gd������ƾ�p5���QGuץaT\|��װ���&�s��*�Q_y�o&��g�����fB�=���{ߎ2ܳh5��8�n)<$(m��mW�'�C=^?��wb�a�kW}����cY�Q�~��l{�gG�;�돍�S�n:*�X7�1�/rW%��ʖ&{�X��B�oP��=��7m�GMÏ;��Dv�h'���f��	�GF���������r:6��os:�6g���9��AY�p/qg	�p8�v7$q�����a�0����9�N��!���n��
`G�i! (�� ��D�6g��p�}@��tfMp��%@2 Өde�,������ �"{9DL��wKo�s�Ӟ��9�Y@�h;�����5(v�I;��%Px�KD��س�n7��Ȫ����D�<
 ���ʂL�
ؠ@��{����)��)�)e��r@���>�@lU�� ?� K����,�P|q�G���:G*~�u��_�XV3;����#�?A�7��x;O�xa�x��&�'l;I�zn#�4a;�<��^Mx	�/	�	�%��"�@� � ��N�ؑ&�ׄ���B�	�n$|�8���L��p;a�.�S�|�'�$|�iT�W���p���S�	?�������y�?O80�����!̦H�a'a[:�'|6� ��m�_#l�*�W���'N��%��p=�w�D8H�����Wv~�p�L�Gx� ���3$>q"�#\@�Gx3� �f�YgJ�8��>�p�E�[�#$�a�Y�9��^G��-�^,��$�Hx�JO�2i�D�M�5�~�}�=����J8��ׄ}��N�Kxa���A�k7�� �sϤ��-�_	�]g�E�	o'�B�[�A��M�ϔ���!�Fxf���"l'l�F�#�O��p�p�Eө>r(�n��^B����	��'l�%�uj|�O��0;W��ٔ��	�	�#�H��p�S]$_�Wf�I�����I�	W�y��#��	D8H���7s%~������Gx�F�w��p�<�/8��C�����D��p�l���vϗ�y�~��n$|�JOxa�d�v~���C����~���<��$�&<b�'<�p�+	���;W�q���%l_,�˄���#�&<�M�!��p�'��pV���ϣ�	n |a�X�%~�	g~����w��\@�!\AؾL��;�K��,�c���$�H�k�m��/"��D���p��I���#�#|7�F�_��WT��������bʏ�d�����	w��/ z�I\N�I�i�-�?&�FxąD�pa{��v�;�,�3.��B�
�~�On$�5��/��	�"̊%�=a'�ї���%�݄_ \OxΥD��}���R�=�/�-�"�Fط���xa7�C���K�=~���r�G-%~	�' |aG����I��/$����~�M���p#�)$�+;�%�����^��<�-������O]F�����0'l������/�+	�$�FXYA�$�M���U�[?BعJ�/!�YH���p#�&�-�?'l_M�ZIx���[s�A�3/#y]I�vީ�$�QD���p�}���A�wH�!�-���#l+�8@x aN�D�I��x
�1���L�C8�p�ń7�Bx;�;	?Jx'�]�_%��B��?>@�w���H<��@��&|���&\L�N��n$��pң?H�G������o"�!�Mx'��R��!�[	�L�>�p;�\�I�I��p*�+�!���d���!�;�W��H����I����Cx��F���	 |>���%^Ix �	�&���d��!��	����p�-��!����%~��`���!���	O������#|�
�7����o'���ㄛ	��3aN�S��"����)e� |<�q�'>��l�s{_L�r�E�7�B�f��&�L�Y�>�I���p*�o�!�PN�'�J���)��"|��G���w^E�U	�E�.�-��O8�����@�_M�U��"<�p6�	/&<��
�s�&�!\M���v�#����%|��.��OJ�၄?!<��jy����Ex!�	��C���E�7.&��ko#�B�A�m��	�Nx�SH8��ׄ�����@x�"�'��𙄷v��p>���"��Z���C��O����	���H�s£	"��p�UԾ�&�'<�p=�s	7��p#a� ��[�J��𣄃�_"̞��τ�?%� ���)���>��B� <��j��Մ�	o'|��� �D�q���D��������I�=၄{����	�'�#<����"���Wn |%�F�[	�K���ӄ��F8H��	�g$���@�	WP{$<�p�S	��Fx1�E�W.$���Z�Մo ����������%v�>�p�:�/ �E��Q�̈́�	7n���n �������~a��_E�y�Ĝp���F�R�N��7K����I�#a'���Qz
/#�B�?$�$<7^�%��#*&z̈́�D/H8H��&��c	gv�"�R�v�~���%�av��_���Jܻ�7P~���H<�p�	��-q� �� ��{T��?'����>�;�p�7��n;V�	�	�M�I�y��'�&�aF85���~j&a;�\���oS�S�>A���� \O� ��f�g����H|��V�K��N⽄��_��"��S����D�v5�^���p�5�z��!� �a�m��M�G��"l�K��;%��p���p#�Ʉ)�X�n�gn#��bJ_F�;�O�G�����N��p�&�,�n!\J���&�A��fJ��J�R�__�O�ۥ�h?�I��/�ސ��s"h�S$n�V���w�ď�����7R�?	�N%�۩�Q�����p�	?O8�$�����t��d�A:o0�0;^�[��/	;�J�П�#��v����"�9j8a�z�g�N��v�Y�$�#a���k$�5���%�'�𵄃k%����j�?S�)~�@ʟ�H�m�?�I�A��!P�'����f�J�[�~/>U�Qx�A��vʏ������7n#��N��>5���w��H�?���t�Nҟ���OnPé���p#��V5>�ה!�^�}L$ \<D��_�p=���p#����q�;gH<�p=��(%�Β�v���	/!z+�J�h�Y�N���sa��/ �B��WP��g�~��9�� �̄�Mx�	�`����&�ׄ?0�	�F� >̈́g��&\n�ך��&����&��	4���(o�g��&�g�e&�фo5�L�O&�M�_&�2҈ǚ�$�i��p�	ט�&�Ǆ�4�I��o%V�˱a��x�	��e&�ń7�M��0�L�=u��0�{L�Մ�g�L�ڄ_4�?��?L�g�<ވ�3�&�ڄo1��Lx�	�`�6��L�#�����6��&�i³Mx�	��6�?�	�8��^�1�GM�2��M�U�g�3��l�.�3��6�,�炝vع`灝��<��`�]v��mr=��`/{؋�^�R��K��]
6lX/�e`��]��J���-[�l)X�˅D����e�-[�l�L��N;��S��v5�5`� {%ث��{5�k����gPփ� ��g�=��`��^v��`�[��x�L< $���pţ�����&�7���`�3��A�;��V<^z���!��릒�gտ��6����6����0�m;���ԟ0�u_ii��f���i����QC�"�G%��lzD�ّs̎�*oA4f�K�L����������l�Έc^��_,���͵i5��"b�h�������S�z��yE����.*�h����ZW<�P�v��G��.�PS�����u!(���#�㘃�+O"��j�L�)z���_sp4�һ�\Xݛ�#2��qS�0>�.���N£YXxt��8ώ�s�2����p#[b0N3��h�S�7��t�H�]
O%:?\<aE�v�0�]-�dn���E���Nz��y��1��D�>�w��[)V�)�4i�f��U6]ȣ�b��0�+vXm�o�b���m�Gg�k��k.vv�$��c�7L�5e���1���h�6�P�L|��/�
S>���>fG���|��-<���e��F��k"}�`�ky'X��'<�ūz�"eDz]Ox�H��1���A��h�(����j�����9�vMˢ�U��oY4��S=�-<����o�z)N��D���"�T�o�	�ԭ�QOu�uYÚ�>Ē��lSz��47 }����|������5�}��t�4��H�E}]R�Ti��&E��%VoS��1���UT݋�"E1�NI)�˓��r�dx9���(b�0b�+邺�J%-Mh�3��(<<��J]����dV�b�Z4k�G���g$��3�����m��{�c_Њ}A+����/h����T��G�/ž|Jt�͉}�����F��`U5�U�°�:�ޜ�	B��n�3�~!j��K\!}zT��0��E'jԺ�C���E���(���y��5�̆t��0}S����tJa��kGE{
�垢Ғ��JV�cps	�"|�M���(-�T2�Ģ��'j�[ �²Y��{D]�z�'��XXXV^!����L=��/>��Zp�R'b�@�f�A"Q)B?p�9C��Z��iG?�����_H�zE$Cs+�.˫,��c�����<.�����wi�rO�R�\���o�vD܉�i���Zv��,�f���`��oe���"CƜ��Ai����J�> ���(iaU!L�
��y��w"k������ʍ�0lv.oΙ'��].��1�����ڕ��/�@s�S<��Å �.��Y��c�y{/?���Z��̑�{6d���Wt�YD���)s&]]2��]3�2oA�G/���w�nt�O2(Д���
y�b\+�^^�-��eP�ڱ�}8�Ej~��Ț�'�c��)�� �;eT�N�\�V.�V��/�H�ۉ���ſ(Vh��oøgE�:[�����-H���w�2��-/�0)�"�@�g,+,*�4�;�Lk?o�u5t��dX����B�*Yi]�U�+"Tvf��I�#�C;(�����Eݺ����(����B�G,�����\��0	������F���(�*!�"!�H5I��j�N{gfYdAIh�1Z������uJ}��|�$%�!(����,�vE��I�uՅz�л�WF�S�]����Cx[��F��_��WE�D��Hs�gЫ>��O��Dٓ�P\��	_,+[�uL[=]�+�r5�%��S:oVq����Uu)��wҢ������Ŧ�wC���}Z薥+8B"��OD?�"�b�9xy�/�� "�C�ݳ�-�L���`Lwl�	����v�!TL�+K��֥���2.rš��n��<�$��9��C���uao.��@�Ͷ���t�.��w��n�q��H�����Nwz�}"��W�N� �2�/
K<�庩R7,�(���Q6�@=MT84�b����y���=�Vrz7����2�V��cQ�2oEa��kw7�U����>?�׭6YG;l>�>��]Z�.�(��p��B�t��,<�X��뢒�bo���X��5�T��R�.���<�T�]���(�H�}�f�aq"�wR����򄁘I������Id�MIv���*X;�CPs�@� }릗��\��MC�Y� @sWe���*V���s�_d�2���b"�&�%yK������2q@�����{�����#�b���ĞqN|�"ĸo����<�V3.[����16�=3��٭�iE�ݥE��k��6񞁵!���)�c�$�KAa�O�+�����ũ�N3�
�L�j,��Z �ǅo��di���t��y�`!����aeɪ�����?�m+�~�_�S;����r�4W�V�8�NVڼ��hh���"�*)9�dܿ��� b)R�줭8��"��bw��X, {�"�;!�`xL|{�50I�ǎ�i�eB�I���lG�
�p`���D6O?��Yg�ie��};J6�{<��f�:�������F�F(_��t6��q���F�0�De�w-��!�}4�������ǩ��a��u����kd�<>N)L���I�3*	N:��aHՀ=	ڈ�I�Pd����g�����u�#p�r���b��t�Y�rL�2\�8���#yһ�H& ��p���ڪ���g� a�j�#u���oLR�k�j3)�-*�m���J`p��x��U�g寇s&�1�<Ȯ�k��Ԍ���f#s���H����j9���~hLh�B��p��#������*� &ӫT��=�n {g�þ4�����w�B��d�jCY��x�����ȁ~��%��%���L#%��n�B� cb���W��E>�SpX�������F{�	��Qk��Z�J}J��T�����z�9M�Eڄ}�̻e�7���"l��p�$��1��F������6 �|gJ-�(���BFTn-ᡭ����6Q�?O��+*���V�w�)Ki$@ƿC�Zꓐ��0w�,�N��MJ�EY�Z���$�)%�h��S��ƛ45�uL^��H�S K���D,��qr�FV��n�)+�����l��vVVZ�y6��#�p���)X�d\	(K��Z6�2�H�i��<�nJ�������%)r|��lu?�����[�y5BᓵBᓌP��ꃵ���Z�)^�*�#ܫ����Ԑ����5�ԕ�1���#w~�z�L�C��39��=��#��{@g�͎�в_�/�Jr�>VF�Zo�7�YB����}�q��������n[����Yφm��17}��:M�"�5=�u���JY �h�fE���&<��ZN���j�>ʚ-�:*kɈ�%#UK=�Eɕ��i �����<�������?2r�׉�9�� ��P�l��e��H�iI'XM���`2bksb�	h�6��R��HwG�'�K�ޅֿ��5�Odx�LfoV5)i̅�� ��/����1K5�h�:��0�"�tM��9C�m��W��4J�e�$R^2,�B��_��*�*��PV�]va��`�{j,ߐ���%���{y���HI�ش��mI�&��h��V�T��4!s�8��)�&�̟��2@����/���|\"������2Ǥ��L�N�C�c�"VJ�M�~�P��';Y$�<���L�d@=�n�@Pڊ�8>�,%�M��7���{�L��7zz%��WJ����C?��f�����:�	,�v��YJ�M���- k=@H�e+.���#+u��`��F��΄���2SvaH3ǒ6 t=y�)�Hm�f������2�3�%)SKF��5����5Va����GG����3�4�T�7���7ժ�ʬW{f�jX�+�b�e�2a�LM���}~f"Q�ԑw�e�V���U�&aD��+Bk��٥���ar�e��ax��jv��`[�"d���Z9YPC�C��D�!rTm!m "r����|VyW3�k�M�Yu���H�n�g��6��T���2ܛ&������?���
�`yWC���m�j���կ����([��MX-�"��M� 2�qQ/"���"��j"b!����,dD��C�w�_G�i>b�-"&U敜
� L�"��l��!�Zf/D�M����!��T'�o�娞A��p�"�� �QGMT��Q���ji���;@�/2V�*2�11Ō>�'c� ��rX
̑APͥ�ӍX
�R��T�5�BUT+!&���,���"㽊x���&.f0P���c���q��d1v�>dtb�j4�K��U����j�Ѩ4����$�R) ��DJ>�pn�������b��K�����$��?�����`u��Z�6m����G��U���6����T�׫զ��٨X��M�Q��l���o����Ko�\�������ΰ���M��ug�f�;������wBn�s�����#u��+q��S���é=*_+pAɾ�����f�c���C��$��LR�r�E	g��!p%����tww�쒟/�v��7��	������������ƙL��GhD	ri��_�ROwF���t��/;�>p��=w�x�[�����Gh#~��B������]��É2�bC����l���Y3��\ZZ���ǅ�)F�u]>	��\b��w��x��|r���c�4���D�n�1Y�Tha�MCt`��:�*��29w�����T��QQS�~�-+�D��O�~@B�bΜ�KK����3�t��%�kG�$
H2�#z�9-!ώ�c���i�Ǉ�|dr�*ѢR�' ��KE�@�C���?e��6J�>f������b�ܸw�lIcJ�ޘ��|`C������F����
 9��A���<n#�̂<a/�.�Fh��G.|��/����
�.����C�&��N��ܙ��eTb(��Ԣz���G��xM	��d�;,���k��[����Z�#�R�Z�v���K+S���_FUE
P�i�K;s(��C��s�r'�V��$��Ξ�ʢ)��t_G}��*�8�]�^|!/���v�n�;�������M>����n���'���Մ�_�U�*���jm��?Ɠ��ߴ�� ��x�����Ls��A p�<~	"�{��n�;۳���{��7��;j��o�,�b�hJy;cIq�Y��]���t�9�]����J�vA'�/� ��H��+x��HP����d����K��.��{BF�{��!��5�$���Ȧ@7��
���g�`6�n���H��p�-�@c��2�-�n�X",��uO���NQ:(s�����	��c#�tW��G�ɚV0h
�<�N�+6e��	�����9F:~���B7�������ø��Hi���' ��m����ͬ��B�g��)�`�+2����2<�dl�+����k꬧��є��f�&��#�'w22
\�S����V9�9�$<e=��<�EzAH:����gU�����^I���Oݤ>`32� ��O&�L8&W>���Tg�Q�M��W.9�҆.Vh�CF1���"�L��Χ#��H�G��e�u�md���Z����f�٪U���o4���c<I����m����Ҹ��s��L�/�s�E�S|ty��.�G��E��Q�?��c�y� n���k�D Y�8�L[^�7�l�y�Z��m�`Kl�sY�,dz6�d��#��оt�����\(�OYӶ��F���0��T�nɮ��D���}y�;�'��R�poq�.�|ߋ�	�R�|�����/S� }fÙ�8��PU��#�ÿ)�K+qf,�5�gL���n8^J��M
�'C�F쿧��S����/��x�{BfXY����
H���4J�Ų� �fQ�ʀ��A�ro̔)s��!vE8~�.}L�O�m�����J��k�ƕ�������:i~`�y-M�X%mC��꺁���)5�r�,%���fd��B��(0� *���YhYxvY9aRO�/9Z�=8��@�����n���J�+?!K�Q��PK�@HZ���U1ꤙι�)1�{����?-tt�NDW�G� ����K7ϊ#ȍ�pkV���^�����xB:�����.�J�v�s2�2����G5)�����	���%5���8d�L=~}�eҍ�^���]���L��E�ˈ������MH���$	�"���C�zØ H�d@��$#��Y`X<�M�����Y�R������5O��d���j�و�?�@��hm���y���Q����G<����p������}p�դQ*���_�&~p�T;��_)�C�#=E�w�I 붒'DT��$�5�o�G�Q_)�L����%	"���4($)h���9(�����\B�DK��EsZX�;T�ǡt��X�{à�I��r���z�/� �f� ��<܃�^E�I��#��f�얿&�z�����.	���#�v��H�IK �œ�x%�!rK0f��l��H;	�4�>��
���
��)EY������%&U9��Ԉ�!,k�Ϋv%�R�������DzQ�rX!�(15�� A*�$���4�YH���05	��ن�~	�d!�0�z��$����$�dѧ{�ܱ��������H�t����+�����qs6W��Y��fl����ln/���׳�h�U���`s��|{67C9l��6��W�xS7����M~p�!b���Џ���Q()��`�#������F������j��ߦ����1����ϰ�|��?�~8{�"=�������u��tE?��aAP�/�r�M܋�n	lX,/S7��M�<F9�ѱKY>��&+%��HC�c����VA8�2K� �xYw\o�e)Ұ��t��w�/	�G)J~"~��e�z��7N �v�YO�[�%���O2ʄĥ4�e�b{g�vz�X|����G$wKe��h�'R�����Aqg�L����8u��|�˅�����SvPɒl�M�T�O|o��Ё:�k���!�R�O�凡{1q�"!w?���_L���2�@4H=��To�t�W��K�-�C��S�­ϰeh��1���\���?$��wOQ���K6��g�����̢�%4��FhG�Տ@H��X��r��h���BOY��)��n/ 8���c(��CQ���Էe5�%�=y�O���:��?'�$�
�c��6��D_����!��$��2P/b�°��A�KQPDt\ _&�ωbt <)��F�"�L��%M��1�B� ��7��?񯮀cp�uo��O�=T�/��y�\(="9]���RP����D�R�-o�Q���U!�a�B��hǙ&:��
4&Ȭ��즉SA�)M�I�'��m���62��!��hX�Z��ߵjs��?�c��y�=�c���h�Q�^; ����q%=<w8S�bRe͋�T߆�����Ss�t/�y|T�0���2wI�_⣡�C�&���I���g6���d~�Z"���=��t���_��JE�H��򴓘YA4V��S�dsQ�ʹ�[=t��.����es+k�fQ<�e�T��M����k2�SQF�I���$����ھܜyg�5˽�!g���6)�ԑ�g:회S��+�~�U�b�	!��9�2�<����U+�������Q�_iY[��z�W�����t۟?}���B��q)ʶ$2��I���k�����ʱ���̱�K��F���7rV
;�*���yV��U�5d�4�l�������i����V-�����[�n��I��O� F��� �X�m ��DN3 ��LA���@[4���������3�3�3s�s4�^i��H�kk&�jOB��ĤG^��������bY_����z������P�/���6��˸�#N��s���)c��g^�m�;��>�V�WLp,��;����s�@��B������'�����r���SȲ��!�lh(�E�@#�&���9\��(���11�Ex��	|إ����!�����Ŏ:���Ov0~���wU���;�p��s#�����^H	@�.�O�7����ˇ5_�7���Ѿ;�}���"'�,��:y�r����9����Ns&�Ċ����7�ھ�h�$��v}��{t�W7=����z͊���7�������?Ɠ���������\/�����'W���I3� �(Foe)�i�U`Ϯ]Hk��3, ]Z���I�"�V��j�"�����Z����e��c�O����3��l+�3�w�+��**v{���V���V�7�+"��\�����yl���'n��)�xd�ڳ�RB�o��1�	������Ľxл_ᩬ|�g�Uom��|��?������_�X[�?����z�E�qIX���Vk{��<���t����2+�~���l���j�Um��E�v��Q��"ב�������q/����k��ߵ�y����w�N������@N:���*���E�s�U{�>�{�H��&/~�R�J�ϺP�a�V��r�,��ԫr6P�`�<��tfp[�?�x%�e �e���,�|��gG�2�rΆq�3?��KwB=���C:����%�%��S�?z��hk�=��r���3$����Wݓ���@��܁H��r��b2wgȭ�3>��G>���5��b�����G�I���[�K@�+�zϷ��p����prv�rC>�n���ӊ8�ggg,˲���=�N)C'��;�;'�Y��k���uN�I*����R����;���hk1��p&�S���.�<�_I���7��������o����`' �~W:d�Io$U����-�z���O���:=��*�n��Rl�wz'�)�X �=RH���
w��V��'�R��F��9�U��{2)E���wCB�J��|�mR���<�X�^LxsH���p��+@���8�b����b ��V�`e��P���8P�]b<��m�bG]���G^9&�?���_"�(�s<ڔ��^����DV��}��9O��\p�	�Ԡ����f����ƃ�)y���x@v��v'��;�����b����i�;Ǆ��SP�A�WƇ*5z��^�?�v�)^��A����¡�w����Y�~Gz�T�LL�RР�tO��	��6(K>~a����B�_S�R��@�#��u`=r1�M||�)w_8 �]1Re�'�=����~v5rH@��]�W�@�|�_������g��>��1]�����+���s�5f�9���TJ���C�`����ı�Ō-��l�������r.h�ψ���H�9� �K?����S���,�ˮ�IR%�~4�p��ѵ3���Dm���2�lH��Z:=v>pQ)Ij�|�"��0�-i��~+vX�C��P�2ag���h��ضH1���p��hW&�'�gS�vH���Ý]�f�>�!�Qp��x�]8fk��\r�0����KڞPt��T���1����!3���#d.��e��nu��G�~
�}�LF`)��&��fVA���h����w��`��#��!_�.4�cOz��K\��P�l�g�����1�.|�sm�8���x��q��!��r�A�6e�����A*kS��֧m3�c�]�4@̘���%'���*����#����Ɋ�@H�*V���?�fe�y�G��W��¾M��ϟ�������}4A������h��[M:�k��6��(��<���8
���؄E���9&��y��œAis�E�H�,���}�=�-���3�����R�;9;b��6��p��tpG���[����9?;m��(P~f��:��O�\+�$��:�����Rz�k�ч|r��2��f��U�	�Ϫ[����Ǵ\H�Cw$G��#3�$�O�4,��'�̲X*�"e�-B���:2x��P�e�X��2�7?jGj[G�P�h�P�-����k6	�����y�DuW�b�=G���~�v�}���:��·�� N�f',� 2�%Ud�7��Qǿ/� &���W���|r�	a��_+k�������fy�Ik����Of�e�9<"G���,ݔ��<��y3;pL���"��^�P-W
,�H�o���������L�i�D�Ab,[���
l��a�d��:,8+�`a-�6X��Z�I�ɰ�Y?����U�}���~J�����x�;�=�uR1(qn�R��}r�I,*fT��w�UCY��Z�O�����pL��:��8b�Z,L.��9�DK��t�P\�ĂGc��a΢M�{(������}�=� �=�^y0���������+�k� w��Bry�Xܤh2/-�%+���{�����f=m�/����Z�/�'6U_B��Ld;]���ET��1�|Q�z��·^?F�%Z8 �� Z2T��_��H��/�;�x)���������$��6��g�l������}� � 